defmodule Api.Accounts.User.Token do
  @moduledoc """
  The user token schema.
  """
  use Api.Schema

  import Ecto.Changeset

  alias __MODULE__
  alias Api.Accounts.User
  alias Api.Repo

  @primary_key {:jti, :binary_id, autogenerate: false}
  @required_attrs [:jti, :typ, :aud, :iss, :sub, :exp, :token, :claims]

  schema "user_tokens" do
    field :typ, :string
    field :aud, :string
    field :iss, :string
    field :exp, :integer
    field :token, :string
    field :claims, :map

    belongs_to :user, User, foreign_key: :sub

    timestamps()
  end

  @doc false
  def changeset(user_token, attrs) do
    user_token
    |> cast(attrs, @required_attrs)
    |> validate_required(@required_attrs)
    |> unique_constraint(:jti, name: :user_tokens_pkey)
    |> assoc_constraint(:user)
  end

  @doc false
  def insert(%{} = attrs) do
    %Token{}
    |> Token.changeset(attrs)
    |> Repo.insert()
  end

  @doc false
  def get(jti) do
    Token
    |> Repo.get!(jti)
    |> then(&{:ok, &1})
  rescue
    _error ->
      :jti
      |> Token.invalid_changeset(jti, "not found")
      |> then(&{:error, &1})
  end

  @doc false
  def get_by([{key, value} | _tail] = params) do
    Token
    |> Repo.get_by!(params)
    |> then(&{:ok, &1})
  rescue
    _error ->
      key
      |> Token.invalid_changeset(value, "not found")
      |> then(&{:error, &1})
  end

  @doc false
  def delete(%Token{} = token), do: Repo.delete(token)
end
