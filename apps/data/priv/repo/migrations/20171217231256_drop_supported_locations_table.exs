defmodule Core.Repo.Migrations.DropSupportedLocationsTable do
  use Ecto.Migration

  def change do
    drop constraint(:collection_schedules, :collection_schedules_supported_location_id_fkey)
    drop table(:supported_locations)
  end
end
