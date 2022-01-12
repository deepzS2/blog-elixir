defmodule Blog.Repo.Migrations.CreateComment do
  use Ecto.Migration

  def change do
    create table(:comment) do
      add :content, :text
      add :post_id, references(:posts, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:comment, [:post_id])
    create index(:comment, [:user_id])
  end
end
