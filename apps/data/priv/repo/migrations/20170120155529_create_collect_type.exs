defmodule Core.Repo.Migrations.CreateCollectType do
  use Ecto.Migration

  def change do
    create table(:collect_types, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :type, :string
      
      timestamps()
    end

    create unique_index(:collect_types, [:type])
  end
end
