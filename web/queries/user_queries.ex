defmodule Cumbia.UserQueries do
  use Cumbia.Web, :model
  alias Cumbia.{MasterQueries}

  defdelegate index(model, query_params), to: MasterQueries
  defdelegate show(model, id), to: MasterQueries
  defdelegate public(model, uuid), to: MasterQueries

end
