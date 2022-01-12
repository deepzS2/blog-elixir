defmodule BlogWeb.PostView do
  use BlogWeb, :view
  alias BlogWeb.PostView
  alias BlogWeb.UserView
  alias BlogWeb.CommentView

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, PostView, "post_with_owner.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, PostView, "post_with_owner_and_comments.json")}
  end

  def render("created.json", %{post: post}) do
    %{data: render_one(post, PostView, "post_with_owner.json")}
  end

  def render("post.json", %{post: post}) do
    %{id: post.id, title: post.title, content: post.content, tags: post.tags}
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

  def render("post_with_owner_and_comments.json", %{post: post}) do
    %{
      id: post.id,
      title: post.title,
      content: post.content,
      tags: post.tags,
      owner: render_one(post.user, UserView, "user_essentials.json"),
      comments: render_many(post.comments, CommentView, "comment_essentials.json")
    }
  end
end
