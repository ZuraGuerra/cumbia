defmodule Cumbia.User do
  use Cumbia.Web, :model

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :fb_id, :string
    field :avatar, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:first_name, :last_name, :email, :fb_id, :avatar])
    |> validate_required([:first_name, :last_name, :email, :fb_id, :avatar])
  end
end
