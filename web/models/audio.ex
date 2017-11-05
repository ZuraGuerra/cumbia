defmodule Cumbia.Audio do
  use Cumbia.Web, :model

  schema "audios" do
    field :name, :string
    field :description, :string
    field :tags, {:array, :string}
    field :file, :binary
    field :duration, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description, :tags, :binary, :duration])
    |> validate_required([:name, :description, :tags, :binary, :duration])
  end
end
