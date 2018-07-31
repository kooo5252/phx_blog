defmodule PhxBlog.AuthController do
  use PhxBlog.Web, :controller

  alias PhxBlog.Auth
  alias PhxBlog.Repo


  def create(conn, %{"auth" => auth_params}) do

    case Auth.login(auth_params) do
      {:ok, token} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", auth_path(conn, :show, token))
        |> render("show.json", auth: token)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PhxBlog.ChangesetView, "error.json", changeset: changeset)
    end
  end


  def delete(conn, %{"id" => id}) do
    auth = Repo.get!(Auth, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(auth)

    send_resp(conn, :no_content, "")
  end
end
