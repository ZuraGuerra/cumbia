defmodule Cumbia.DashboardController do
  use Cumbia.Web, :controller

  alias Cumbia.{MasterQueries}

  def show(conn, %{"project_id" => project_id, "audio_id" => audio_id}) do
    project = MasterQueries.show(Cumbia.Project, project_id)
    audio = MasterQueries.show(Cumbia.Audio, audio_id)
    # render
  end

  def show(conn, %{"project_id" => project_id}) do
    project = MasterQueries.show(Cumbia.Project, project_id)

    audio_query_params = [preload: :audio_data, where: [project_id: project_id]]
    project_audios = MasterQueries.index(Cumbia.Audio, audio_query_params)
    # render
  end

  def index(conn, _) do
    projects = MasterQueries.index(Cumbia.Project, [preload: :audio])
    # render
  end

  def new(conn, _) do
    # render new project form
  end

end
