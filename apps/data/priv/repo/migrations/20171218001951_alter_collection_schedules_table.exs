defmodule Core.Repo.Migrations.AlterCollectionSchedulesTable do
  use Ecto.Migration

  def change do
    alter table(:collection_schedules) do
      add :location_slug, :string
      add :name, :string
    end
  end
end
