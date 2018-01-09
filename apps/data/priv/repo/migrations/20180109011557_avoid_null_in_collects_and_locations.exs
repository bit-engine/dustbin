defmodule Dustbin.Data.Repo.Migrations.AvoidNullInCollectsAndLocations do
  use Ecto.Migration

  def change do
    alter table(:collection_schedules) do
      modify :scheduled_date, :date, null: false
      modify :name, :string, null: false
      add :details, :string
      remove :type
    end

    alter table(:locations) do
      modify :slug, :string, null: false
      modify :display_name, :string, null: false
      modify :timezone, :string, null: false
    end
  end
end
