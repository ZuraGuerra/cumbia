defmodule Cumbia.MasterQueries do
  use Cumbia.Web, :model

  def show(entity_model, id) do
    entity_model
    |> where([entity], entity.id == ^id)
    |> where([entity], entity.is_deleted == false)
  end

  def public(entity_model, uuid) do
    entity_model
    |> where([entity], entity.uuid == ^uuid)
    |> where([entity], entity.is_deleted == false)
  end

  def index(entity_model, params \\ []) do
    params = params |> check_params
    base_query = entity_model
               |> from([where: ^params[:where],
                        limit: ^params[:limit],
                        order_by: ^params[:order_by]])
    base_query = if params[:preload],
                  do: base_query |> preload(^params[:preload]),
                else: base_query

    base_query = if params[:except],
                  do: base_query |> query_except(params[:except]),
                else: base_query
  end

  # This can also be written to accept any operator
  defp query_except(base_query, params) when is_list(params) do
    Enum.reduce(params, base_query, fn({key, value}, query) ->
      from entity in query,
      where: field(entity, ^key) != ^value
    end)
  end

  defp check_params(params) do
    {_, params} = params |> Keyword.get_and_update(:where, &validate_where/1)
    {_, params} = params |> Keyword.get_and_update(:limit, &validate_limit/1)
    {_, params} = params
                |> Keyword.get_and_update(:order_by, &validate_order_by/1)
    params
  end

  defp validate_where(nil), do: {nil, [is_deleted: false]}
  defp validate_where(params) when is_list(params),
    do: {params, params ++ [is_deleted: false]}

  defp validate_limit(nil), do: {nil, 20}
  defp validate_limit(params), do: {params, params}

  defp validate_order_by(nil), do: {nil, [:updated_at]}
  defp validate_order_by(params), do: {params, params}
end
