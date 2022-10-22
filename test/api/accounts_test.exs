defmodule Api.AccountsTest do
  use Api.DataCase

  import Api.Factory

  alias Api.Accounts
  alias Api.Accounts.User
  alias Ecto.Changeset

  describe "list_users/0" do
    test "without users returns an empty list" do
      assert Accounts.list_users() == []
    end

    test "with users returns all users" do
      user = insert(:user)

      assert Accounts.list_users() == [user]
    end
  end

  describe "get_user/1" do
    setup [:insert_user]

    test "returns the user with given id", %{user: user} do
      assert Accounts.get_user(user.id) == {:ok, user}
    end

    test "returns an invalid changeset if the given id is not found" do
      id = Ecto.UUID.generate()

      assert {:error, %Changeset{} = changeset} = Accounts.get_user(id)
      assert errors = errors_on(changeset)
      assert errors.id == ["not found"]
    end
  end

  describe "create_user/1" do
    test "with valid data creates a user" do
      valid_attrs = params_for(:user)

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.email == valid_attrs.email
      assert user.name == valid_attrs.name
      assert String.starts_with?(user.password, "$argon2")
    end

    test "with invalid data returns an invalid changeset" do
      invalid_attrs = %{email: "?", name: nil, password: "?"}

      assert {:error, %Changeset{} = changeset} = Accounts.create_user(invalid_attrs)
      assert errors = errors_on(changeset)
      assert errors.email == ["has invalid format", "should be at least 3 character(s)"]
      assert errors.name == ["can't be blank"]
      assert errors.password == ["should be at least 3 character(s)"]
    end
  end

  describe "update_user/2" do
    setup [:insert_user]

    test "with valid data updates the user", %{user: user} do
      update_attrs = params_for(:user)

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.email == update_attrs.email
      assert user.name == update_attrs.name
      assert String.starts_with?(user.password, "$argon2")
    end

    test "with invalid data returns an invalid changeset", %{user: user} do
      invalid_attrs = %{email: "@", name: "?", password: nil}

      assert {:error, %Changeset{} = changeset} = Accounts.update_user(user, invalid_attrs)
      assert errors = errors_on(changeset)
      assert errors.email == ["should be at least 3 character(s)"]
      assert errors.name == ["should be at least 2 character(s)"]
      assert errors.password == ["can't be blank"]
      assert {:ok, user} == Accounts.get_user(user.id)
    end
  end

  describe "delete_user/1" do
    setup [:insert_user]

    test "deletes the user", %{user: user} do
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert {:error, %Changeset{} = changeset} = Accounts.get_user(user.id)
      assert errors = errors_on(changeset)
      assert errors.id == ["not found"]
    end
  end

  describe "change_user/1" do
    setup [:insert_user]

    test "returns a changeset", %{user: user} do
      assert %Changeset{} = Accounts.change_user(user)
    end
  end

  defp insert_user(_) do
    user = insert(:user)

    {:ok, user: user}
  end
end
