defmodule Cumbia.AudioDataTest do
  use Cumbia.ModelCase

  alias Cumbia.AudioData

  @valid_attrs %{acousticness: 42, danceability: 42, duration: 42, energy: 42, key: "some content", liveness: 42, loudness: 42, speechness: 42, tempo: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = AudioData.changeset(%AudioData{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = AudioData.changeset(%AudioData{}, @invalid_attrs)
    refute changeset.valid?
  end
end
