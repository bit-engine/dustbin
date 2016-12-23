defmodule Dustbin.Repo.Migrations.AddUniqueIndexToCollectType do
  use Ecto.Migration

  def change do
    create unique_index(:collect_types, [:name])
  end
end
