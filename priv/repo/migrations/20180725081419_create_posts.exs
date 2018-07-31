defmodule PhxBlog.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:post) do
      add :username, :string, null: false
      add :title, :string, null: false, size: 40
      add :body, :text, null: false
      add :access_count, :integer, default: 0

      timestamps()
    end

  end
end
