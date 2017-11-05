defmodule Cumbia.FilteredAudioTest do
  use Cumbia.ModelCase

  alias Cumbia.FilteredAudio

  @valid_attrs %{binary: "some content", filter_params: %{}, hearted: true, name: "some content", notes: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = FilteredAudio.changeset(%FilteredAudio{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = FilteredAudio.changeset(%FilteredAudio{}, @invalid_attrs)
    refute changeset.valid?
  end
end
