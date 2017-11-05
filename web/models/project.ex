defmodule Cumbia.Project do
  use Cumbia.Web, :model

  schema "projects" do
    field :name, :string
    field :description, :string
    field :youtube_url, :string
    field :tags, {:array, :string}

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description, :youtube_url, :tags])
    |> validate_required([:name, :description, :youtube_url, :tags])
  end
end
