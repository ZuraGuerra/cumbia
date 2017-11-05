defmodule Cumbia.MasterServices do
  alias Cumbia.{Repo, GeneralParsers}

  def before_creation(conn, data, entity_name) do
    model_module = GeneralParsers.module_name(entity_name, :model)
    {:ok, model_module.creation(data)}
  end

  def after_creation(conn, entity), do: {conn, entity}

  def before_modification(data, action, entity_name) do
    model_module = GeneralParsers.module_name(entity_name, :model)
    case Repo.get(model_module, data["id"]) do
      # The entity exists, so we create a changeset
      # based on the action we want to perform on it
      entity = %{__struct__: ^model_module} ->
        {:ok, apply(model_module,
                    action |> String.to_atom,
                    [entity, data])}
      # The entity doesn't exists (maybe our identificator is invalid)
      nil -> {:error, nil}
    end
  end

  def after_modification(conn, entity, _action), do: {conn, entity}
end
