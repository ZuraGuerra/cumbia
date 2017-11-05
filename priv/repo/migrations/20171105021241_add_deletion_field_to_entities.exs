defmodule Cumbia.Repo.Migrations.AddDeletionFieldToEntities do
  use Ecto.Migration

  def change do
    alter table(:users), do: add :is_deleted, :boolean
    alter table(:projects), do: add :is_deleted, :boolean
    alter table(:audios), do: add :is_deleted, :boolean
    alter table(:filtered_audios), do: add :is_deleted, :boolean
    alter table(:audio_data), do: add :is_deleted, :boolean
  end
end
