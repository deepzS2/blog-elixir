defmodule BlogWeb.CommentView do
  use BlogWeb, :view

  alias BlogWeb.CommentView
  alias BlogWeb.PostView
  alias BlogWeb.UserView

  def render("index.json", %{comment: comment}) do
    %{data: render_many(comment, CommentView, "comment.json")}
  end

  def render("show.json", %{comment: comment}) do
    %{data: render_one(comment, CommentView, "comment.json")}
  end

  def render("comment.json", %{comment: comment}) do
    %{
      id: comment.id,
      content: comment.content,
      post: render_one(comment.post, PostView, "post_with_owner.json"),
      owner: render_one(comment.user, UserView, "user_essentials.json")
    }
  end

  def render("comment_essentials.json", %{comment: comment}) do
    %{
      id: comment.id,
      content: comment.content,
      owner: render_one(comment.user, UserView, "user_essentials.json")
    }
  end
end
