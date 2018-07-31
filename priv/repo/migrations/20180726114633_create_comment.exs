defmodule PhxBlog.Repo.Migrations.CreateComment do
  use Ecto.Migration

  def change do
    create table(:comment) do
      add :title, :string, null: false, size: 40
      add :name, :string, size: 20, default: "Anonymous"
      add :body, :text, null: false
      add :pass, :string, size: 8
      add :mail, :string, size: 40
      add :post_id, :integer

      timestamps()
    end

  end
end
