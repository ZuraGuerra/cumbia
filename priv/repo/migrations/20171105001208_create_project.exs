defmodule Cumbia.Repo.Migrations.CreateProject do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :name, :string
      add :description, :text
      add :youtube_url, :string
      add :tags, {:array, :string}

      timestamps()
    end

  end
end
