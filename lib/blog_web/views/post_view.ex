defmodule BlogWeb.PostView do
  use BlogWeb, :view
  alias BlogWeb.PostView
  alias BlogWeb.UserView

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, PostView, "post_with_owner.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, PostView, "post_with_owner.json")}
  end

  def render("post.json", %{post: post}) do
    %{id: post.id, title: post.title, content: post.content, tags: post.tags}
  end

  def render("unauthorized_owner.json", %{}) do
    %{message: "You are not the owner of the post!"}
  end

  def render("post_with_owner.json", %{post: post}) do
    %{
      id: post.id,
      title: post.title,
      content: post.content,
      tags: post.tags,
      owner: render_one(post.user, UserView, "user_essentials.json")
    }
  end
end
