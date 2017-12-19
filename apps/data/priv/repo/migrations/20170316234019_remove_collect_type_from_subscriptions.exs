defmodule Core.Repo.Migrations.RemoveCollectTypeFromSubscriptions do
  use Ecto.Migration

  def change do
    drop index(:subscriptions, [:supported_location_id, :collect_type_id])
    alter table(:subscriptions) do
      remove :collect_type_id
    end
    create index(:subscriptions, [:supported_location_id])
  end
end
