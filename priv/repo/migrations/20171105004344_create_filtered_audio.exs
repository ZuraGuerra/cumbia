defmodule Cumbia.Repo.Migrations.CreateFilteredAudio do
  use Ecto.Migration

  def change do
    create table(:filtered_audios) do
      add :file, :binary
      add :filter_params, :map
      add :name, :string
      add :hearted, :boolean, default: false, null: false
      add :notes, :text

      timestamps()
    end

  end
end
