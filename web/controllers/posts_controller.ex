defmodule PhxBlog.PostsController do
  use PhxBlog.Web, :controller

  alias PhxBlog.User
  alias PhxBlog.Posts

  def index(conn, _params) do
    sorted = from(p in Posts, order_by: [desc: p.inserted_at])
    post = Repo.all(sorted)
    render(conn, "index.html", post: post)
  end

  def userpost(conn, %{"name" => username}) do
    sorted = from(p in Posts, order_by: [desc: p.inserted_at])
    post = sorted
           |> where([p], p.username == ^username)
           |> Repo.all()
    render(conn, "index.html", post: post)
  end

  def mypost(conn, _params) do
    username = current_user(conn).username
    sorted = from(p in Posts, order_by: [desc: p.inserted_at])
    post = sorted
           |> where([p], p.username == ^username)
           |> Repo.all()
    render(conn, "index.html", post: post)
  end

  def search(conn, %{"query" => query}) do
    post = Posts
           |> where([p], like(p.body, ^("%#{query}%")))
           |> Repo.all()
    render(conn, "index.html", post: post)
  end

  def ranking() do
    sorted = from(p in Posts, order_by: [desc: p.access_count])
    post = sorted
           |> where([p], p.access_count > 0)
           |> Repo.all()
    post
  end

  def new(conn, _params) do
    if logged_in?(conn) do
      changeset = Posts.changeset(%Posts{})
      render(conn, "new.html", changeset: changeset)
    else
      conn
      |> put_flash(:info, "ユーザー限定機能を行うにはログインが必要です")
      |> redirect(to: session_path(conn, :new))
    end
  end

  def create(conn, %{"posts" => posts_params}) do
    if logged_in?(conn) do
      changeset = Posts.changeset(%Posts{}, posts_params)

      case Repo.insert(changeset) do
        {:ok, _posts} ->
          conn
          |> put_flash(:info, "Posts created successfully.")
          |> redirect(to: posts_path(conn, :index))
        {:error, changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    posts = Repo.get!(Posts, id)
    user = Repo.get_by(User, username: posts.username)
    render(conn, "show.html", [posts: posts, user: user])
    posts
    |> Posts.changeset(%{access_count: posts.access_count + 1})
    |> Repo.update()
  end

  def edit(conn, %{"id" => id}) do
    posts = Repo.get!(Posts, id)
    if posts.username == current_user(conn).username do
      changeset = Posts.changeset(posts)
      render(conn, "edit.html", posts: posts, changeset: changeset)
    else
      conn
      |> put_flash(:info, "違うユーザーの記事です")
      |> redirect(to: posts_path(conn, :index))
    end
  end

  def update(conn, %{"id" => id, "posts" => posts_params}) do
    authenticate_user!(conn)
    if logged_in?(conn) do
      posts = Repo.get!(Posts, id)
      changeset = Posts.changeset(posts, posts_params)

      case Repo.update(changeset) do
        {:ok, posts} ->
          conn
          |> put_flash(:info, "Posts updated successfully.")
          |> redirect(to: posts_path(conn, :show, posts))
        {:error, changeset} ->
          render(conn, "edit.html", posts: posts, changeset: changeset)
      end
    end
  end

  def delete(conn, %{"id" => id}) do
    authenticate_user!(conn)
    posts = Repo.get!(Posts, id)
    if posts.username == current_user(conn).username do

      # Here we use delete! (with a bang) because we expect
      # it to always work (and if it does not, it will raise).
      Repo.delete!(posts)

      conn
      |> put_flash(:info, "Posts deleted successfully.")
      |> redirect(to: posts_path(conn, :index))
    else
      conn
      |> put_flash(:info, "違うユーザーの記事です")
      |> redirect(to: posts_path(conn, :index))
    end
  end


  defp authenticate_user!(conn) do
    unless logged_in?(conn) do
      conn
        |> put_flash(:info, "ユーザー限定機能を行うにはログインが必要です")
        |> redirect(to: session_path(conn, :new))
    end
    conn  # plug は connを返す必要がある
  end
end
