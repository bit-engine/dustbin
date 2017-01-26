defmodule Core.Repo.Migrations.AddLocation do
  use Ecto.Migration

  def change do
    create table(:supported_locations, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :city, :string
      add :province_or_state, :string
      add :country, :string
      add :country_code, :string

      timestamps()
    end
  end
end
