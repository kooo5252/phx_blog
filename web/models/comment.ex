defmodule PhxBlog.Comment do
  use PhxBlog.Web, :model

  schema "comment" do
    field :title, :string
    field :name, :string
    field :body, :string
    field :pass, :string
    field :mail, :string
    field :post_id, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :name, :body, :pass, :mail, :post_id])
    |> validate_required([:title, :body, :post_id])
  end
end
