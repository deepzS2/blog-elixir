defmodule Blog.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :content, :string
    field :tags, {:array, :string}
    field :title, :string

    # One to many relationship, references id and the field is user_id by default
    # field :user_id, :id
    belongs_to :user, Blog.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :tags, :user_id])
    |> validate_required([:title, :content, :tags, :user_id])
    # Checks the foreign key
    |> foreign_key_constraint(:user_id)
  end
end
