defmodule PhxBlog.User do
  use PhxBlog.Web, :model

  alias PhxBlog.Repo

  schema "users" do
    field :username, :string
    field :password, :string, virtual: true
    field :crypted_password, :string
    field :nickname, :string
    field :userimageurl, :string

    timestamps()
  end

  def create(changeset) do
    changeset
    |> put_change(:crypted_password, changeset.params["password"])
    |> Repo.insert()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :password, :nickname, :userimageurl])
    |> unique_constraint(:username)
    |> validate_required([:username, :password])
  end

  defp hashed_password(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end
end
