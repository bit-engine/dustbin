defmodule Core.CollectTypeTest do
  use Core.Case

  @valid_attrs %{type: "Trash"}
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
