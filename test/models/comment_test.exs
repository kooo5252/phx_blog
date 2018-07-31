defmodule PhxBlog.CommentTest do
  use PhxBlog.ModelCase

  alias PhxBlog.Comment

  @valid_attrs %{body: "some content", mail: "some content", name: "some content", pass: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Comment.changeset(%Comment{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Comment.changeset(%Comment{}, @invalid_attrs)
    refute changeset.valid?
  end
end
