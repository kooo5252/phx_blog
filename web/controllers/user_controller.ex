defmodule PhxBlog.UserController do
  use PhxBlog.Web, :controller

  alias PhxBlog.User
  alias PhxBlog.Posts
  alias ExAws.S3

  @default_region "us-east-1"
  @default_bucket "my_phoenix_"

  def index(conn, _params) do
    if logged_in?(conn) do
      users = User
              |> where([u], u.username != ^current_user(conn).username)
              |> Repo.all()
    else
      users = Repo.all(User)
    end
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    unless logged_in?(conn) do
      changeset = User.changeset(%User{})
      render(conn, "new.html", changeset: changeset)
    else
      conn
      |> put_flash(:info, "既にログインしています")
      |> redirect(to: user_path(conn, :edit))
    end
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case User.create(changeset) do
      {:ok, user} ->
        S3.put_bucket(@default_bucket <> user.username, @default_region)
        conn
        |> put_session(:current_user, user.id)
        |> put_flash(:info, "User created successfully.")
        |> render("edit.html", user: user, changeset: changeset)
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"name" => username}) do
    unless username == current_user(conn).username do
      user = Repo.get_by(User, username: username)
      render(conn, "show.html", user: user)
    else
      redirect(conn, to: user_path(conn, :edit))
    end 
  end

  def edit(conn, _params) do
    if logged_in?(conn) do
      user = Repo.get!(User, current_user(conn).id)
      changeset = User.changeset(user)
      render(conn, "edit.html", user: user, changeset: changeset)
    else
      conn
      |> put_flash(:info, "ユーザー限定機能を行うにはログインが必要です")
      |> redirect(to: session_path(conn, :new))  
    end
  end


#↓本当はwith文を使いたい


  def upload_photo(conn, %{"upload" => %{"file" => file}}) do
    user = Repo.get!(User, current_user(conn).id)
    changeset = User.changeset(user)
    bucket =  @default_bucket <> current_user(conn).username
    case File.read(file.path) do
      {:ok, file_binary} ->
        case S3.put_object(bucket, "profile", file_binary)
             |> ExAws.request() do
          {:ok, _} -> 
            case S3.presigned_url(ExAws.Config.new(:s3), :get, bucket, "profile", [virtual_host: true]) do
              {:ok, url} ->
                user
                |> User.changeset(%{userimageurl: url})
                |> Repo.update()
                conn
                |> put_flash(:success, "File uploaded successfully!")
                |> render(conn, "edit.html", user: user, changeset: changeset)
              _ ->
                conn
                |> put_flash(:success, "File uploaded failed!")
                |> render(conn, "edit.html", user: user, changeset: changeset)
            end
          _ ->
            conn
            |> put_flash(:success, "File uploaded failed!")
            |> render(conn, "edit.html", user: user, changeset: changeset)
        end
      _ ->
        conn
        |> put_flash(:success, "File uploaded failed!")
        |> render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def update(conn, %{"username" => username, "user" => user_params}) do
    user = Repo.get_by(User, username: username)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, _params) do
    if logged_in?(conn) do
      username = current_user(conn).username
      Social
      |> where([s], s.follow == ^username)
      |> Repo.delete_all()
      Social
      |> where([s], s.followed == ^username)
      |> Repo.delete_all()
      Posts
      |> where([p], p.username == ^username)
      |> Repo.delete_all()
      user = Repo.get!(User, current_user(conn).id)
      # Here we use delete! (with a bang) because we expect
      # it to always work (and if it does not, it will raise).
      Repo.delete!(user)

      force_delete_bucket(username)

      conn
      |> put_flash(:info, "User deleted successfully.")
      |> redirect(to: user_path(conn, :index))
    else
      conn
      |> put_flash(:info, "ユーザー限定機能を行うにはログインが必要です")
      |> redirect(to: session_path(conn, :new))  
    end
  end

  def force_delete_bucket(username) do
    bucket = @default_bucket <> username
    %{body: %{contents: contents}} =
      bucket
      |> ExAws.S3.list_objects()
      |> ExAws.request!()

    objects =
      contents
      |> Enum.map(& &1.key)

    ExAws.S3.delete_all_objects(bucket, objects)
    |> ExAws.request!()

    ExAws.S3.delete_bucket(bucket)
    |> ExAws.request()
    end
end
