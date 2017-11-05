defmodule Cumbia.FilteredAudio do
  use Cumbia.Web, :model

  schema "filtered_audios" do
    field :file, :binary
    field :filter_params, :map
    field :name, :string
    field :hearted, :boolean, default: false
    field :notes, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:binary, :filter_params, :name, :hearted, :notes])
    |> validate_required([:binary, :filter_params, :name, :hearted, :notes])
  end
end
