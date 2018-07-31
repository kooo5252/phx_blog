defmodule PhxBlog.PostsControllerTest do
  use PhxBlog.ConnCase

  alias PhxBlog.Posts
  @valid_attrs %{body: "some content", title: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, posts_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing post"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, posts_path(conn, :new)
    assert html_response(conn, 200) =~ "New posts"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, posts_path(conn, :create), posts: @valid_attrs
    assert redirected_to(conn) == posts_path(conn, :index)
    assert Repo.get_by(Posts, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, posts_path(conn, :create), posts: @invalid_attrs
    assert html_response(conn, 200) =~ "New posts"
  end

  test "shows chosen resource", %{conn: conn} do
    posts = Repo.insert! %Posts{}
    conn = get conn, posts_path(conn, :show, posts)
    assert html_response(conn, 200) =~ "Show posts"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, posts_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    posts = Repo.insert! %Posts{}
    conn = get conn, posts_path(conn, :edit, posts)
    assert html_response(conn, 200) =~ "Edit posts"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    posts = Repo.insert! %Posts{}
    conn = put conn, posts_path(conn, :update, posts), posts: @valid_attrs
    assert redirected_to(conn) == posts_path(conn, :show, posts)
    assert Repo.get_by(Posts, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    posts = Repo.insert! %Posts{}
    conn = put conn, posts_path(conn, :update, posts), posts: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit posts"
  end

  test "deletes chosen resource", %{conn: conn} do
    posts = Repo.insert! %Posts{}
    conn = delete conn, posts_path(conn, :delete, posts)
    assert redirected_to(conn) == posts_path(conn, :index)
    refute Repo.get(Posts, posts.id)
  end
end
