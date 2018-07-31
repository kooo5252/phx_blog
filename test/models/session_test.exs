defmodule PhxBlog.SessionTest do
  use PhxBlog.ModelCase

  alias PhxBlog.Session

  @valid_attrs %{follow: true, nickname: "some content", password: "some content", userimageurl: "some content", username: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Session.changeset(%Session{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Session.changeset(%Session{}, @invalid_attrs)
    refute changeset.valid?
  end
end
