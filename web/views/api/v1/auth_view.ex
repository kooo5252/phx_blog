defmodule PhxBlog.AuthView do
  use PhxBlog.Web, :view

  def render("index.json", %{auth: auth}) do
    %{data: render_many(auth, PhxBlog.AuthView, "auth.json")}
  end

  def render("show.json", %{auth: auth}) do
    %{data: render_one(auth, PhxBlog.AuthView, "auth.json")}
  end

  def render("auth.json", %{auth: auth}) do
    %{id: auth.id,
      username: auth.username,
      token: auth.token}
  end
end
