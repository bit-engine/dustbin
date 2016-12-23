defmodule Dustbin.Repo.Migrations.CreateCollectType do
  use Ecto.Migration

  def change do
    create table(:collect_types, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string

      timestamps()
    end

  end
end
