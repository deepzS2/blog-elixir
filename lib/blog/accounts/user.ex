defmodule Blog.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Comeonin.Bcrypt

  schema "users" do
    field(:email, :string)
    field(:password, :string)
    field(:name, :string)

    # One to many relationship, returns array and gets all posts with this user id
    has_many :posts, Blog.Posts.Post

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> unique_constraint(:email)
    # Invoke hashpwsalt function with encrypted_password argument
    |> update_change(:password, &Bcrypt.hashpwsalt/1)
  end
end
