defmodule BlogWeb.UserView do
  use BlogWeb, :view
  alias BlogWeb.UserView
  alias BlogWeb.PostView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user_essentials.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user_with_posts.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      encrypted_password: user.password
    }
  end

  def render("user_essentials.json", %{user: user}) do
    %{id: user.id, name: user.name, email: user.email}
  end

  def render("user_with_posts.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      posts: render_many(user.posts, PostView, "post.json")
    }
  end
end
