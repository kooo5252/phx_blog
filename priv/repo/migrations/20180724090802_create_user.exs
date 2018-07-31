defmodule PhxBlog.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false
      add :crypted_password, :string, null: false
      add :nickname, :string, default: nil
      add :userimageurl, :string, default: nil

      timestamps()
    end

    create unique_index(:users, [:username])

  end
end
