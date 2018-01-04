defmodule Dustbin.Data.Repo.Migrations.RemoveLocationIdIndexInSchedules do
  use Ecto.Migration

  def change do
    drop index(:collection_schedules, :location_id)
  end
end
