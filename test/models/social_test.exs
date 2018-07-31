defmodule PhxBlog.SocialTest do
  use PhxBlog.ModelCase

  alias PhxBlog.Social

  @valid_attrs %{follow: "some content", followed: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Social.changeset(%Social{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Social.changeset(%Social{}, @invalid_attrs)
    refute changeset.valid?
  end
end
