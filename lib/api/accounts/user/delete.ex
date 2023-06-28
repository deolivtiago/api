defmodule Api.Accounts.User.Delete do
  @moduledoc false
  alias Api.Accounts.User
  alias Api.Repo

  @doc false
  def call(%User{} = user), do: Repo.delete(user)
end
