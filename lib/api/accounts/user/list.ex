defmodule Api.Accounts.User.List do
  @moduledoc false
  alias Api.Accounts.User
  alias Api.Repo

  @doc false
  def call, do: Repo.all(User)
end
