defmodule Cumbia.AudioData do
  use Cumbia.Web, :model

  schema "audio_data" do
    field :danceability, :float
    field :energy, :float
    field :key, :string
    field :loudness, :float
    field :speechness, :float
    field :acousticness, :float
    field :tempo, :float
    field :liveness, :float
    field :duration, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:danceability, :energy, :key, :loudness, :speechness, :acousticness, :tempo, :liveness, :duration])
    |> validate_required([:danceability, :energy, :key, :loudness, :speechness, :acousticness, :tempo, :liveness, :duration])
  end
end
