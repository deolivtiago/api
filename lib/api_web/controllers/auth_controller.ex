defmodule ApiWeb.AuthController do
  @moduledoc """
  Handles auth requests
  """
  use ApiWeb, :controller

  alias Api.Accounts
  alias ApiWeb.Auth.AuthHandler

  action_fallback ApiWeb.FallbackController

  @doc """
  Handles requests to sign up.
  """
  def signup(conn, %{"user" => user_params}) do
    with {:ok, _user} <- Accounts.create_user(user_params),
         {:ok, auth} <- AuthHandler.authenticate_user(user_params) do
      conn
      |> put_status(:created)
      |> render(:show, auth: auth)
    end
  end

  @doc """
  Handles requests to sign in.
  """
  def signin(conn, %{"credentials" => user_credentials}) do
    with {:ok, auth} <- AuthHandler.authenticate_user(user_credentials) do
      render(conn, :show, auth: auth)
    end
  end

  def refresh(conn, _params) do
    [auth_header] = get_req_header(conn, "authorization")

    with {:ok, auth} <- AuthHandler.refresh_user_tokens(auth_header) do
      render(conn, :show, auth: auth)
    end
  end
end
