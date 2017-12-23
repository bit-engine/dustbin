defmodule Dustbin.Data.Repo.Migrations.AddFkeyToCollectionSchedules do
  use Ecto.Migration

  def change do
    alter table(:collection_schedules) do
      remove :location_slug
      add :location_id, references(:locations, type: :uuid)
    end

    create unique_index(:collection_schedules, [:location_id])
  end
end
