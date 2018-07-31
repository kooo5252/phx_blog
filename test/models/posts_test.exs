defmodule PhxBlog.PostsTest do
  use PhxBlog.ModelCase

  alias PhxBlog.Posts

  @valid_attrs %{body: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Posts.changeset(%Posts{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Posts.changeset(%Posts{}, @invalid_attrs)
    refute changeset.valid?
  end
end
