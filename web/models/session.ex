defmodule PhxBlog.Session do
  use PhxBlog.Web, :model

  alias PhxBlog.User
  alias PhxBlog.Repo



  def login(params) do
    result = User
             |> where([u], u.username == ^params["username"])
             |> where([u], u.crypted_password == ^params["password"])
             |> Repo.all()
    # ユーザーが存在すればユーザー一覧ページにリダイレクトされます
    case length(result) > 0 do
      true -> {:ok, Repo.get_by(User, username: params["username"])}
      false -> :error
    end
  end

  def logged_in?(conn) do
    !!current_user(conn)
  end

  def current_user(conn) do
    id = Plug.Conn.get_session(conn, :current_user)
    if id, do: Repo.get(User, id)
  end

  defp authenticate(user, password) do
    case user do
      nil -> false
      _   -> Comeonin.Bcrypt.checkpw(password, user.crypted_password)
    end
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :password, :nickname, :userimageurl, :follow])
    |> validate_required([:username, :password])
  end

end