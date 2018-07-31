defmodule PhxBlog.Repo.Migrations.CreateSocial do
  use Ecto.Migration

  def change do
    create table(:social) do
      add :follow, :string
      add :followed, :string

      timestamps()
    end

  end
end
