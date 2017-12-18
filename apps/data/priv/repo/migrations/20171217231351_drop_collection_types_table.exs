defmodule Core.Repo.Migrations.DropCollectionTypesTable do
  use Ecto.Migration

  def change do
    drop constraint(:collection_schedules, :collection_schedules_collect_type_id_fkey)
    drop table(:collect_types)
  end
end
