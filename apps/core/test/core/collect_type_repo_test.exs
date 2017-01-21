defmodule Core.CollectTypeRepoTest do
  use Core.Case

  test "collect_types id is uuid" do
    changeset = CollectType.changeset(%CollectType{}, %{type: "Trash"})
    {:ok, collect_type} = Repo.insert changeset
    <<_::64, ?-, _::32, ?-, _::32, ?-, _::32, ?-, _::96>> = collect_type.id
  end
end
