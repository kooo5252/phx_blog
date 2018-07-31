defmodule PhxBlog.PageController do
  use PhxBlog.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
