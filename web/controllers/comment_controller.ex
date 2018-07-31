defmodule PhxBlog.CommentController do
  use PhxBlog.Web, :controller

  alias PhxBlog.Comment

  def comment_index(conn, %{"id" => id}) do
    comment = Comment
              |> where([c], c.post_id == ^id)
              |> Repo.all()
    comment
  end

  def create(conn, %{"comment" => comment_params, "id" => id}) do
    changeset = Comment.changeset(%Comment{}, comment_params)

    case Repo.insert(changeset) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: posts_path(conn, :show, id))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Repo.get!(Comment, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(comment)

    conn
    |> put_flash(:info, "Comment deleted successfully.")
    |> redirect(to: posts_path(conn, :show, id))
  end
end
