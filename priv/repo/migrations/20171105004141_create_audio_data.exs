defmodule Cumbia.Repo.Migrations.CreateAudioData do
  use Ecto.Migration

  def change do
    create table(:audio_data) do
      add :danceability, :float
      add :energy, :float
      add :key, :string
      add :loudness, :float
      add :speechness, :float
      add :acousticness, :float
      add :tempo, :float
      add :liveness, :float
      add :duration, :integer

      timestamps()
    end

  end
end
