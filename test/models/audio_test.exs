defmodule Cumbia.AudioTest do
  use Cumbia.ModelCase

  alias Cumbia.Audio

  @valid_attrs %{binary: "some content", description: "some content", duration: 42, name: "some content", tags: []}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Audio.changeset(%Audio{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Audio.changeset(%Audio{}, @invalid_attrs)
    refute changeset.valid?
  end
end
