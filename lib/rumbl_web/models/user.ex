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

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(pass))
      _ ->
        changeset
    end
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, ~w(name username)a, empty_values: [])
    |> validate_length(:username, min: 1, max: 20)
  end

  def registration_changeset(model, params) do
    model
    |> changeset(params)
    |> cast(params, ~w(password)a, empty_values: [])
    |> validate_length(:password, min: 6, max: 100)
    |> put_pass_hash()
  end
end
