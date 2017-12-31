defmodule Dustbin.Data.Repo.Migrations.ModifyLocationIdIdxInSchedules do
  use Ecto.Migration

  def change do
    drop index(:collection_schedules, [:location_id])
    create index(:collection_schedules, [:location_id], unique: false)
  end
end
