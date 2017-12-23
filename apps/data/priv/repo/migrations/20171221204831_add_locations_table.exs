defmodule Dustbin.Data.Repo.Migrations.AddLocationsTable do
  use Ecto.Migration

  def change do
    create table(:locations, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :slug, :string
      add :display_name, :string
      add :timezone, :string

      timestamps()
    end
  end
end
