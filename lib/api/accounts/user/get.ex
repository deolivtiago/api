defmodule Api.Accounts.User.Get do
  @moduledoc false
  alias Api.Accounts.User
  alias Api.Repo

  @doc false
  def call(email: email) do
    User
    |> Repo.get_by!(email: String.downcase(email))
    |> then(&{:ok, &1})
  rescue
    _error ->
      :email
      |> User.invalid_changeset(email, "not found")
      |> then(&{:error, &1})
  end

  @doc false
  def call(id) do
    User
    |> Repo.get!(id)
    |> then(&{:ok, &1})
  rescue
    _error ->
      :id
      |> User.invalid_changeset(id, "not found")
      |> then(&{:error, &1})
  end
end
