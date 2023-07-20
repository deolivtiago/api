defmodule ApiWeb.Auth.Guardian do
  @moduledoc false
  use Guardian, otp_app: :api

  alias Api.Accounts
  alias Api.Accounts.User

  def subject_for_token(%User{} = user, _), do: {:ok, user.id}
  def subject_for_token(_, _), do: {:error, :unhandled_resource_type}

  def resource_from_claims(%{"sub" => id}), do: Accounts.get_user(id)
  def resource_from_claims(_), do: {:error, :unhandled_resource_type}

  def after_encode_and_sign(_resource, %{"typ" => "refresh"} = claims, token, _options) do
    claims
    |> Map.put("claims", claims)
    |> Map.put("token", token)
    |> User.Token.insert()

    {:ok, token}
  end

  def after_encode_and_sign(_resource, _claims, token, _options), do: {:ok, token}

  def on_verify(%{"typ" => "refresh"} = claims, token, _options) do
    with {:ok, _user_token} <- User.Token.get_by(token: token) do
      {:ok, claims}
    end
  end

  def on_verify(claims, _token, _options), do: {:ok, claims}

  def on_refresh({old_token, old_claims}, {new_token, new_claims}, _options) do
    after_encode_and_sign(%{}, new_claims, new_token, [])
    on_revoke(old_claims, old_token, [])

    {:ok, {old_token, old_claims}, {new_token, new_claims}}
  end

  def on_revoke(claims, token, _options) do
    with {:ok, user_token} <- User.Token.get_by(token: token) do
      User.Token.delete(user_token)
    end

    {:ok, claims}
  end
end
