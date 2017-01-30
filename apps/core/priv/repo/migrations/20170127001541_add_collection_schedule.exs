defmodule Core.Repo.Migrations.AddCollectionSchedules do
  use Ecto.Migration

  def change do
    create table(:collection_schedules, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :scheduled_date, :date
      add :utc_offset, :string
      add :supported_location_id, references(:supported_locations, type: :binary_id)
      add :collect_type_id, references(:collect_types, type: :binary_id)

      timestamps()
    end

    create index(:collection_schedules, [:supported_location_id, :collect_type_id])
  end
end
