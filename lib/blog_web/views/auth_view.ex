defmodule BlogWeb.AuthView do
  use BlogWeb, :view

  alias BlogWeb.UserView

  def render("show.json", %{user: user}) do
    %{user: render_one(user, UserView, "user_essentials.json")}
  end

  def render("authenticated.json", %{user: user, token: token}) do
    %{user: render_one(user, UserView, "user_essentials.json"), token: token}
  end
end
