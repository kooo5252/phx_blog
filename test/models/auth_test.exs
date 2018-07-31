defmodule PhxBlog.AuthTest do
  use PhxBlog.ModelCase

  alias PhxBlog.Auth

  @valid_attrs %{token: "some content", username: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Auth.changeset(%Auth{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Auth.changeset(%Auth{}, @invalid_attrs)
    refute changeset.valid?
  end
end
