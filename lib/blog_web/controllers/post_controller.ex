defmodule BlogWeb.PostController do
  use BlogWeb, :controller

  require Logger

  alias Blog.Posts
  alias Blog.Posts.Post
  alias Blog.Repo

  action_fallback BlogWeb.FallbackController

  plug :authenticate when action in [:create, :update, :delete]

  def index(conn, _params) do
    posts = Posts.list_posts()

    render(conn, "index.json", posts: posts)
  end

  def create(conn, %{"post" => post_params}) do
    # Merge the post map with the user_id
    # Note that we don't use atom here!
    post = Map.merge(post_params, %{"user_id" => conn.assigns.current_user})

    with {:ok, %Post{} = post} <- Posts.create_post(post) do
      # TODO: change it so preload on `posts.ex`
      post = Repo.preload(post, :user)

      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.post_path(conn, :show, post))
      |> render("show.json", post: post)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Posts.get_post!(id)
    render(conn, "show.json", post: post)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Posts.get_post!(id)
    user_id = conn.assigns.current_user

    # If the post owner id matches the authenticated user id
    if post.user_id == user_id do
      with {:ok, %Post{} = post} <- Posts.update_post(post, post_params) do
        render(conn, "show.json", post: post)
      end
    else
      render(conn, "unauthorized_owner.json")
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Posts.get_post!(id)
    user_id = conn.assigns.current_user

    # If the post owner id matches the authenticated user id
    if post.user_id == user_id do
      with {:ok, %Post{}} <- Posts.delete_post(post) do
        send_resp(conn, :no_content, "")
      end
    else
      render(conn, "unauthorized_owner.json")
    end
  end
end
