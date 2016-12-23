defmodule Dustbin.CollectTypeTest do
  use Dustbin.ModelCase

  alias Dustbin.CollectType
  alias Dustbin.Repo

  @valid_attrs %{name: "Trash"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = CollectType.changeset(%CollectType{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = CollectType.changeset(%CollectType{}, @invalid_attrs)
    refute changeset.valid?
  end
end
