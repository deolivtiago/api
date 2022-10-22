defmodule ApiWeb.UserControllerTest do
  use ApiWeb.ConnCase

  import Api.Factory

  @invalid_attrs %{email: "@", name: nil, password: "?"}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index/2" do
    setup [:insert_user]

    test "lists all users", %{conn: conn, user: user} do
      conn = get(conn, Routes.user_path(conn, :index))

      assert %{"success" => true, "data" => data} = json_response(conn, 200)
      assert [user_data] = data["users"]
      assert user_data["id"] == user.id
      assert user_data["email"] == user.email
      assert user_data["name"] == user.name
    end
  end

  describe "create/2" do
    test "renders user when data is valid", %{conn: conn} do
      create_attrs = params_for(:user)

      conn = post(conn, Routes.user_path(conn, :create), user: create_attrs)

      assert %{"success" => true, "data" => data} = json_response(conn, 201)
      assert data["user"]["email"] == create_attrs.email
      assert data["user"]["name"] == create_attrs.name
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)
      assert errors["user"]["email"] == ["should be at least 3 character(s)"]
      assert errors["user"]["name"] == ["can't be blank"]
      assert errors["user"]["password"] == ["should be at least 3 character(s)"]
    end
  end

  describe "show/2" do
    setup [:insert_user]

    test "renders the user with given id", %{conn: conn, user: user} do
      conn = get(conn, Routes.user_path(conn, :show, user.id))

      assert %{"success" => true, "data" => data} = json_response(conn, 200)
      assert data["user"]["id"] == user.id
      assert data["user"]["email"] == user.email
      assert data["user"]["name"] == user.name
    end

    test "renders error when the given id is not found", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :show, Ecto.UUID.generate()))

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)
      assert errors["user"]["id"] == ["not found"]
    end
  end

  describe "update/2" do
    setup [:insert_user]

    test "renders user when data is valid", %{conn: conn, user: user} do
      update_attrs = params_for(:user)

      conn = put(conn, Routes.user_path(conn, :update, user), user: update_attrs)

      assert %{"success" => true, "data" => data} = json_response(conn, 200)
      assert data["user"]["id"] == user.id
      assert data["user"]["email"] == update_attrs.email
      assert data["user"]["name"] == update_attrs.name
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)
      assert errors["user"]["email"] == ["should be at least 3 character(s)"]
      assert errors["user"]["name"] == ["can't be blank"]
      assert errors["user"]["password"] == ["should be at least 3 character(s)"]
    end
  end

  describe "delete/2" do
    setup [:insert_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))

      assert response(conn, 204)

      conn = get(conn, Routes.user_path(conn, :show, user))

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)
      assert errors["user"]["id"] == ["not found"]
    end
  end

  defp insert_user(_) do
    user = insert(:user)

    {:ok, user: user}
  end
end
