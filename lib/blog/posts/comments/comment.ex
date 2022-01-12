defmodule Blog.Posts.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  require Logger

  schema "comment" do
    field :content, :string

    belongs_to :user, Blog.Accounts.User
    belongs_to :post, Blog.Posts.Post

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:content, :post_id, :user_id])
    |> validate_required([:content, :post_id, :user_id])
    # Checks the foreign keys
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:post_id)
  end
end
