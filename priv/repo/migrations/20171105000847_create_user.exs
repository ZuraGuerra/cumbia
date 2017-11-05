defmodule Cumbia.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :fb_id, :string
      add :avatar, :string

      timestamps()
    end

  end
end
