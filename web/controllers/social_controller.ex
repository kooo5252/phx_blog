defmodule PhxBlog.SocialController do
  use PhxBlog.Web, :controller

  alias PhxBlog.Social

  def follow(conn) do
    username = current_user(conn).username
    social = Social
             |> where([s], s.follow == ^username)
             |> Repo.all()
    social
  end

  def follower(conn) do
    username = current_user(conn).username
    social = Social
             |> where([s], s.followed == ^username)
             |> Repo.all()
    social
  end

  def create(conn, %{"followed" => followed}) do
    username = current_user(conn).username
    if username != followed do
      changeset = Social.changeset(%Social{}, %{follow: username, followed: followed})

      [url] = get_req_header(conn, "referer")

      case Repo.insert(changeset) do
        {:ok, _social} ->
          conn
          |> put_flash(:info, "Follow successfully.")
          |> redirect(external: url)
        {:error, changeset} ->
          conn
          |> put_flash(:info, "Follow failed.")
          |> redirect(external: url)
      end
    end
  end

  def delete(conn, %{"name" => followed}) do
    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Social
    |> where([s], s.follow == ^current_user(conn).username)
    |> where([s], s.followed == ^followed)
    |> Repo.delete_all()

    [url] = get_req_header(conn, "referer")

    conn
    |> put_flash(:info, "Unfollow successfully.")
    |> redirect(external: url)
  end

  def follow?(conn, username) do
    result = Social
             |> where([s], s.follow == ^current_user(conn).username)
             |> where([s], s.followed == ^username)
             |> Repo.all()
    if length(result) > 0 do
      true
    else
      nil
    end
  end
end
