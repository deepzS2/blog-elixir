defmodule BlogWeb.AuthController do
  use BlogWeb, :controller

  alias Blog.Accounts
  alias Blog.Accounts.User
  alias Blog.Auth
  alias Comeonin.Bcrypt

  action_fallback(BlogWeb.FallbackController)

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def new(conn, %{"email" => email, "password" => password}) do
    case Accounts.get_user_by_email!(email) do
      %User{} = user ->
        if Bcrypt.checkpw(password, user.password) do
          token = Auth.generate_token(user.id)

          conn |> render("authenticated.json", user: user, token: token)
        else
          conn |> put_status(401) |> json(%{message: "User or password invalid!"})
        end

      nil ->
        conn |> put_status(401) |> json(%{message: "User or password invalid!"})
    end
  end
end
