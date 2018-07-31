defmodule PhxBlog.Auth do
  use PhxBlog.Web, :model

  alias PhxBlog.User
  alias PhxBlog.Repo
  alias PhxBlog.Auth

  schema "auth" do
    field :username, :string
    field :token, :string
    field :lifetime, :integer

    timestamps()
  end

  def login(params) do
    result = User
             |> where([u], u.username == ^params["username"])
             |> where([u], u.crypted_password == ^params["password"])
             |> Repo.all()
    # ユーザーが存在すれば発行したトークンをusernameと紐づけて登録
    if length(result) > 0 do
      token = params["username"] #<-今度ハッシュ化する
      changeset = Auth.changeset(%Auth{}, params)
      case changeset
           |> put_change(:token, token)
           |> Repo.insert() do
        true  -> {:ok, token}
        false -> {:error, changeset}
      end
    end
  end


  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :token])
    |> validate_required([:username, :token])
  end
end
