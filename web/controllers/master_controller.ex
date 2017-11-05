defmodule Cumbia.MasterController do
  use Cumbia.Web, :controller
  require Logger

  alias Cumbia.{GeneralParsers,
                Repo,
                SuccessView,
                ErrorView,
                ConfigLoader}

  def create(conn, %{"entity_name" => entity_name,
                            "data" => data}) do
    entity_name = GeneralParsers.entity_name(entity_name)
    services_module = GeneralParsers.module_name(entity_name, :services)
    model_module = GeneralParsers.module_name(entity_name, :model)
    # Before creation logic (if any)
    # (this generates a changeset if the data is valid)
    case services_module.before_creation(conn, data, entity_name) do
      {:ok, changeset} ->
        case Repo.insert(changeset) do
          {:ok, created_entity} ->
            # After creation logic (if any)
            {conn, created_entity} = entity_name
                                   |> GeneralParsers.module_name(:services)
                                   |> apply(:after_creation, [conn, created_entity])

            # Respond to client
            conn
            |> put_status(:created)
            |> render(SuccessView, "success.json", entity_name: entity_name,
                                                          data: created_entity)
          {:error, changeset} ->
            errors = changeset.errors |> GeneralParsers.changeset_errors

            conn
            |> put_status(status_chooser(errors))
            |> render(ErrorView, "error.json", changeset_errors: errors)
        end
      {:error, _} ->
        conn
        |> put_status(:forbidden)
        |> render(ErrorView, "error.json", message: "Your request is invalid")
    end
  end

  def modify(conn, %{"data" => data,
                   "action" => action,
              "entity_name" => entity_name}) do
    entity_name = GeneralParsers.entity_name(entity_name)
    services_module = GeneralParsers.module_name(entity_name, :services)
    action = GeneralParsers.action(action)
    # Before modification logic (if any)
    # (this generates a changeset if the data is valid)
    case services_module.before_modification(data, action, entity_name) do
      {:ok, changeset} ->
        case Repo.update(changeset) do
          {:ok, modified_entity} ->
            # After modification logic (if any)
            {conn, modified_entity} = entity_name
                                    |> GeneralParsers.module_name(:services)
                                    |> apply(:after_modification,
                                             [conn, modified_entity, action])

            # Respond to client
            conn
            |> put_status(:ok)
            |> render(SuccessView, "success.json", entity_name: entity_name,
                                                          data: modified_entity)
          {:error, changeset} ->
            errors = changeset.errors |> GeneralParsers.changeset_errors
            conn
            |> put_status(status_chooser(errors))
            |> render(ErrorView, "error.json", changeset_errors: errors)
        end
      {:error, _} ->
        conn
        |> put_status(:not_modified)
        |> render(ErrorView, "error.json", message: "Your request is invalid")
    end
  end

  # TODO: move this to a single lib
  defp check_jwt(conn = %Plug.Conn{cookies: %{"jwt" => jwt}}) do
    case JsonWebToken.verify(jwt, %{key: ConfigLoader.secret_key_base}) do
      {:ok, claims} -> {conn, claims}
      _ -> {conn, nil}
    end
  end

  defp check_jwt(conn) do
    {conn, nil}
  end

  def show(conn, %{"id" => id, "entity_name" => entity_name}) do
    entity_name = GeneralParsers.entity_name(entity_name)
    model_module = GeneralParsers.module_name(entity_name, :model)
    queries_module = GeneralParsers.module_name(entity_name, :queries)

    # TODO: move this to users controller?
    if id == "me" do
      {conn, claims} = check_jwt(conn |> Plug.Conn.fetch_cookies)
      if claims != nil do
        id = claims.id
      end
    end

    case model_module |> queries_module.show(id) |> Repo.one do
      entity = %{__struct__: ^model_module} ->
        conn
        |> put_status(:ok)
        |> render(SuccessView, "success.json", entity_name: entity_name,
                                                      data: entity)
      nil ->
        conn
        |> put_status(:not_found)
        |> render(ErrorView, "error.json", message: "You cannot access this entity")
    end
  end

  # This should be inside a SupportController or something...
  def index(conn, %{"entity_name" => entity_name,
                 "subentity_name" => subentity_name,
                      "entity_param" => entity_param}) do
    query = %{}
         |> Map.put("where",
                    %{entity_query_param_handler(entity_name, subentity_name)
                      => entity_param})
    params = %{}
           |> Map.put("q", query)
           |> Map.put("entity_name", subentity_name)
    index(conn, params)
  end

  # This should be inside a SupportController or something...
  def index(conn, %{"entity_name" => entity_name, "except" => user_id}) do
    query = %{"except" => %{"user_id" => user_id}}
    params = %{}
           |> Map.put("q", query)
           |> Map.put("entity_name", entity_name)
    index(conn, params)
  end

  def index(conn, params = %{"entity_name" => entity_name}) do
    entity_name = GeneralParsers.entity_name(entity_name)
    model_module = GeneralParsers.module_name(entity_name, :model)

    queries_module = GeneralParsers.module_name(entity_name, :queries)
    query_params = GeneralParsers.query_params(params)
    case model_module |> queries_module.index(query_params) |> Repo.all do
      entities = [%{__struct__: ^model_module}|_] ->
        conn
        |> put_status(:ok)
        |> render(SuccessView, "success.json", entity_name: entity_name,
                                                      data: entities)
      entities = [] ->
        conn
        |> put_status(:ok)
        |> render(SuccessView, "success.json", entity_name: entity_name,
                                                      data: entities)
      nil ->
        conn
        |> put_status(:forbidden)
        |> render(ErrorView, "error.json", message: "You cannot access this entity")
    end
  end

  defp entity_query_param_handler("users", "assertions"), do: "user_email"
  defp entity_query_param_handler(entity_name, _),
    do: GeneralParsers.entity_name(entity_name) <> "_id"

  defp status_chooser(%{email: _error_message}), do: :conflict
  defp status_chooser(_errors), do: :bad_request

end
