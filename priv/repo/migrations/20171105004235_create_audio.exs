defmodule Cumbia.Repo.Migrations.CreateAudio do
  use Ecto.Migration

  def change do
    create table(:audios) do
      add :name, :string
      add :description, :text
      add :tags, {:array, :string}
      add :file, :binary
      add :duration, :integer

      timestamps()
    end

  end
end
