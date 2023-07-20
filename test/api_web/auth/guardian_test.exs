defmodule ApiWeb.Auth.GuardianTest do
  use Api.DataCase

  import Api.Factories.UserFactory

  alias Api.Accounts.User.Token
  alias ApiWeb.Auth.Guardian
  alias Ecto.Changeset

  describe "subject_for_token/2 returns" do
    setup [:insert_user]

    test "success when resource is valid", %{user: user} do
      assert {:ok, user.id} == Guardian.subject_for_token(user, %{})
    end

    test "error when resource is invalid" do
      assert {:error, :unhandled_resource_type} == Guardian.subject_for_token(%{}, %{})
    end
  end

  describe "resource_from_claims/1 returns" do
    setup [:insert_user]

    test "success when token is valid", %{user: user} do
      assert {:ok, user} == Guardian.resource_from_claims(%{"sub" => user.id})
    end

    test "error when token is invalid" do
      assert {:error, :unhandled_resource_type} == Guardian.resource_from_claims(%{})
    end
  end

  describe "after_encode_and_sign/4 with refresh token" do
    setup [:insert_user, :put_token_and_claims]

    test "inserts the token in the database", %{user: user, token: token, claims: claims} do
      Token.get_by(token: token) |> then(fn {:ok, user_token} -> Token.delete(user_token) end)

      assert {:ok, _token} = Guardian.after_encode_and_sign(user, %{"typ" => "access"}, token, [])
      assert {:ok, token} = Guardian.after_encode_and_sign(user, claims, token, [])
      assert {:ok, _user_token} = Token.get_by(token: token)
    end
  end

  describe "on_verify/3 with refresh token" do
    setup [:insert_user, :put_token_and_claims]

    test "returns :ok when token is found", %{token: token, claims: claims} do
      assert {:ok, claims} == Guardian.on_verify(claims, token, [])
    end

    test "returns :error when token is not found", %{claims: claims} do
      assert {:error, changeset} = Guardian.on_verify(claims, "token", [])
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.token, "not found")
    end
  end

  describe "on_refresh/3 with refresh token" do
    setup [:insert_user, :put_token_and_claims]

    test "deletes the old token and inserts the new one", %{token: old_token} do
      assert {:ok, {old_token, _}, {new_token, _}} = Guardian.refresh(old_token)

      assert {:ok, _user_token} = Token.get_by(token: new_token)
      assert {:error, changeset} = Token.get_by(token: old_token)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.token, "not found")
    end
  end

  describe "on_revoke/3 with refresh token" do
    setup [:insert_user, :put_token_and_claims]

    test "deletes the given token", %{token: token, claims: claims} do
      assert {:ok, claims} == Guardian.on_revoke(claims, token, [])
      assert {:error, changeset} = Token.get_by(token: token)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.token, "not found")
    end
  end

  defp insert_user(_) do
    :user
    |> insert()
    |> Map.put(:password, nil)
    |> then(&{:ok, user: &1})
  end

  defp put_token_and_claims(%{user: user}) do
    {:ok, token, claims} =
      Guardian.encode_and_sign(user, %{}, token_type: "refresh", ttl: {48, :hour})

    {:ok, claims: claims, token: token}
  end
end
