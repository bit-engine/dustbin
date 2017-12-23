defmodule Dustbin.Data.Repo.Migrations.DeprecateOldFkeys do
  use Ecto.Migration

  def change do
    alter table(:collection_schedules) do
      remove :supported_location_id
      remove :collect_type_id
    end
  end
end
