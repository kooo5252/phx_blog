defmodule PhxBlog.Posts do
  use PhxBlog.Web, :model

  schema "post" do
    field :username, :string
    field :title, :string
    field :body, :string
    field :access_count, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :title, :body, :access_count])
    |> validate_required([:username, :title, :body])
  end
end
