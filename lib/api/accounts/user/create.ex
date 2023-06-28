defmodule Api.Accounts.User.Create do
  @moduledoc false
  alias Api.Accounts.User
  alias Api.Repo

  @doc false
  def call(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
