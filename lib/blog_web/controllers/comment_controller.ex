defmodule BlogWeb.CommentController do
  use BlogWeb, :controller

  alias Blog.Posts.Comments
  alias Blog.Posts.Comments.Comment

  action_fallback BlogWeb.FallbackController

  require Logger

  plug :authenticate when action in [:create, :update, :delete]

  def index(conn, _params) do
    comment = Comments.list_comment()
    render(conn, "index.json", comment: comment)
  end

  def create(conn, %{"comment" => comment_params, "id" => post}) do
    # Merge the post map with the user_id
    # Note that we don't use atom here!
    with {post_id, _} <- Integer.parse(post) do
      comment =
        comment_params
        |> Map.put(
          "user_id",
          conn.assigns.current_user
        )
        |> Map.put("post_id", post_id)

      Logger.debug(comment)

      with {:ok, %Comment{}} <-
             Comments.create_comment(comment) do
        conn
        |> put_status(:created)
        |> json(%{message: "Comment created!"})
      end
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Comments.get_comment!(id)
    render(conn, "show.json", comment: comment)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Comments.get_comment!(id)
    user_id = conn.assigns.current_user

    if comment.user_id == user_id do
      with {:ok, %Comment{} = comment} <- Comments.update_comment(comment, comment_params) do
        send_resp(conn, :no_content, "")
      end
    else
      conn |> put_status(401) |> render(BlogWeb.ErrorView, "unauthorized.json")
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Comments.get_comment!(id)
    user_id = conn.assigns.current_user

    if comment.user_id == user_id do
      with {:ok, %Comment{}} <- Comments.delete_comment(comment) do
        send_resp(conn, :no_content, "")
      end
    else
      conn |> put_status(401) |> render(BlogWeb.ErrorView, "unauthorized.json")
    end
  end
end
