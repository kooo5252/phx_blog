defmodule PhxBlog.Social do
  use PhxBlog.Web, :model

  schema "social" do
    field :follow, :string
    field :followed, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:follow, :followed])
    |> validate_required([:follow, :followed])
  end
end
