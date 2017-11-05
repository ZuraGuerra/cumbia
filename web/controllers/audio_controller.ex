defmodule Cumbia.Cumbia.AudioController do
  use Cumbia.Web, :controller

  def generate(conn, %{"genre" => genre, "project_id" => project_id}) do
    # pass genre to 1st Python script, persist generated audio
    # pass generated audio to 2nd Python script, persist audio data
    # render results
  end
end
