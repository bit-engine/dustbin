defmodule Dustbin.Data.Repo.Migrations.UniqueLocationSlug do
  use Ecto.Migration

  def change do
    create unique_index(:locations, [:slug])
  end
end
