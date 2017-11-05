defmodule Cumbia.AudioServices do
  use Cumbia.Web, :controller

  alias Cumbia.{MasterServices}

  defdelegate before_creation(conn, data, entity_name), to: MasterServices
  defdelegate after_creation(conn, entity), to: MasterServices

  defdelegate before_modification(data, action, entity), to: MasterServices
  defdelegate after_modification(conn, entity, action), to: MasterServices
end
