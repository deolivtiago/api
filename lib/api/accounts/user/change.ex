defmodule Api.Accounts.User.Change do
  @moduledoc false
  alias Api.Accounts.User

  @doc false
  def call(%User{} = user, attrs \\ %{}), do: User.changeset(user, attrs)
end
