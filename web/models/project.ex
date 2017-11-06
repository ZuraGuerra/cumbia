defmodule Cumbia.Project do
  use Cumbia.Web, :model

  @creation_fields ~w(name description tags)a

  schema "projects" do
    field :name, :string
    field :description, :string
    field :youtube_url, :string
    field :tags, {:array, :string}

    timestamps()
  end

  def creation(params) do
    %Cumbia.Project{}
    |> cast(params, @creation_fields)
    |> validate_required(@creation_fields)
  end
end
