defmodule PhxBlog.Repo.Migrations.CreateSession do
  use Ecto.Migration

  def change do
    create table(:session) do
      add :username, :string
      add :password, :string
      add :nickname, :string
      add :userimageurl, :string
      add :follow, :boolean, default: false, null: false

      timestamps()
    end

  end
end
