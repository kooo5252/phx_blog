defmodule PhxBlog.Repo.Migrations.CreateAuth do
  use Ecto.Migration

  def change do
    create table(:auth) do
      add :username, :string
      add :token, :string
      add :lifetime, :integer, default: 86400

      timestamps()
    end

  end
end
