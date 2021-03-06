defmodule PhxBlog.UserTest do
  use PhxBlog.ModelCase

  alias PhxBlog.User

  @valid_attrs %{follow: true, nickname: "some content", password: "some content", userimageurl: "some content", username: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
