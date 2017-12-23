defmodule Dustbin.Data.Repo.Migrations.DropCollectionSchedulesIndexes do
  use Ecto.Migration

  def change do
    drop index(:collection_schedules, [:supported_location_id, :collect_type_id])
  end
end
