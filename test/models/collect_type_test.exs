defmodule Dustbin.CollectTypeTest do
  use Dustbin.ModelCase

  alias Dustbin.CollectType
  alias Dustbin.Repo

  @valid_attrs %{name: "Trash"}
  @invalid_attrs %{}

  test "changeset is valid when all required attributes are present" do
    changeset = CollectType.changeset(%CollectType{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset is invalid when no attributes are provided" do
    changeset = CollectType.changeset(%CollectType{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset is invalid when empty required attributes are provided" do
    changeset = CollectType.changeset(%CollectType{}, %{name: ""})
    refute changeset.valid?
  end

  test "CollectType id is type uuid" do
    changeset = CollectType.changeset(%CollectType{}, @valid_attrs)
    {:ok, collect_type} = Repo.insert changeset
    <<_::64, ?-, _::32, ?-, _::32, ?-, _::32, ?-, _::96>> = collect_type.id
  end
end
