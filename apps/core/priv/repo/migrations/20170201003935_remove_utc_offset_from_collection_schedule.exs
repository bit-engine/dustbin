defmodule Core.Repo.Migrations.RemoveUtcOffsetFromCollectionSchedule do
  use Ecto.Migration

  def change do
    alter table(:collection_schedules) do
      remove :utc_offset
    end
  end
end
