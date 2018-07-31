defmodule PhxBlog.SessionController do
  use PhxBlog.Web, :controller
require Logger

  alias PhxBlog.Session

  def init(default), do: default

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, session_params) do

    case Session.login(session_params) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id)
        |> put_flash(:info, "Log in successfully.")
        |> redirect(to: "/")
      :error ->
        conn
        |> put_flash(:info, "メールアドレスかパスワードが間違っています")
        render("new.html")
    end
  end


  def delete(conn, _) do
    conn
    |> delete_session(:current_user)
    |> put_flash(:info, "Log out")
    |> redirect(to: "/")
  end
end
