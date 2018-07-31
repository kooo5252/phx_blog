defmodule PhxBlog.SocialControllerTest do
  use PhxBlog.ConnCase

  alias PhxBlog.Social
  @valid_attrs %{follow: "some content", followed: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, social_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing social"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, social_path(conn, :new)
    assert html_response(conn, 200) =~ "New social"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, social_path(conn, :create), social: @valid_attrs
    assert redirected_to(conn) == social_path(conn, :index)
    assert Repo.get_by(Social, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, social_path(conn, :create), social: @invalid_attrs
    assert html_response(conn, 200) =~ "New social"
  end

  test "shows chosen resource", %{conn: conn} do
    social = Repo.insert! %Social{}
    conn = get conn, social_path(conn, :show, social)
    assert html_response(conn, 200) =~ "Show social"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, social_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    social = Repo.insert! %Social{}
    conn = get conn, social_path(conn, :edit, social)
    assert html_response(conn, 200) =~ "Edit social"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    social = Repo.insert! %Social{}
    conn = put conn, social_path(conn, :update, social), social: @valid_attrs
    assert redirected_to(conn) == social_path(conn, :show, social)
    assert Repo.get_by(Social, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    social = Repo.insert! %Social{}
    conn = put conn, social_path(conn, :update, social), social: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit social"
  end

  test "deletes chosen resource", %{conn: conn} do
    social = Repo.insert! %Social{}
    conn = delete conn, social_path(conn, :delete, social)
    assert redirected_to(conn) == social_path(conn, :index)
    refute Repo.get(Social, social.id)
  end
end
