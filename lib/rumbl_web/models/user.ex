defmodule Rumbl.User do
  @moduledoc false
  use RumblWeb, :model

  schema "users" do
    field :name, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, ~w(name username)a, empty_values: [])
    |> validate_length(:username, min: 1, max: 20)
  end
end
