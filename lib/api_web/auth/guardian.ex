defmodule ApiWeb.Auth.Guardian do
  @moduledoc false
  use Guardian, otp_app: :api

  alias Api.Accounts
  alias Api.Accounts.User

  def subject_for_token(%User{} = user, _), do: {:ok, user.id}
  def subject_for_token(_, _), do: {:error, :unhandled_resource_type}

  def resource_from_claims(%{"sub" => id}), do: Accounts.get_user(id)
  def resource_from_claims(_), do: {:error, :unhandled_resource_type}
end
