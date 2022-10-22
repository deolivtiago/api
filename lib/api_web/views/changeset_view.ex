defmodule ApiWeb.ChangesetView do
  use ApiWeb, :view

  alias Api.Accounts.User

  @doc """
  Traverses and translates changeset errors.

  See `Ecto.Changeset.traverse_errors/2` and
  `ApiWeb.ErrorHelpers.translate_error/1` for more details.
  """
  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end

  def render("error.json", %{changeset: %{data: %User{}} = changeset}) do
    %{success: false, errors: %{user: translate_errors(changeset)}}
  end
end
