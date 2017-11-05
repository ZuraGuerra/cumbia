defmodule Cumbia.GeneralParsers do
  def module_name(name, :model) do
    submodule_name = name # ex. "user_lists"
                   |> String.split(["_", "-"], trim: true) # ["user", "list"]
                   |> Enum.map(&String.capitalize/1) # ["User", "List"]
                   |> Enum.join # "UserList"
    Module.concat(Sphingi, submodule_name)
  end

  def module_name(name, suffix) when is_atom(suffix) do
    suffix = suffix |> to_string # ex. :services -> "services"
    name = name <> "_" <> suffix # "user_services"
    module_name(name, :model)
  end

  def action(action), do: action |> String.replace("-", "_")
  def entity_name(name),
    do: name |> String.trim_trailing("s") |> String.trim_trailing("e")

  def query_params(%{"q" => params}), do: params |> Enum.map(&single_query/1)
  def query_params(%{"entity_name" => _}), do: []

  def changeset_errors(errors) do
    Enum.map(errors, &single_error/1)
    |> Map.new(fn(error_tuple) -> error_tuple end)
  end

  def provider_key(provider),
    do: provider |> Kernel.<>("_id") |> String.to_atom

  defp single_error({field, {details, _}}), do: {field, details}

  defp single_query({expression, options}) when is_map(options) do
    options = options # %{"order_by" => "20", "limit" => 10}
            |> Enum.map(&single_query/1) # [order_by: "20", limit: 10]
    {expression, options} |> single_query
  end

  defp single_query(params = {"order_by", _}) do
    params
    |> Tuple.to_list
    |> Enum.map(&String.to_atom/1)
    |> List.to_tuple
  end

  defp single_query({expression, options}),
    do: {expression |> String.to_atom, options}
end
