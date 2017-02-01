defmodule Core.Repo.Migrations.AddTimezoneToSupportedLocation do
  use Ecto.Migration

  def change do
    alter table(:supported_locations) do
      add :timezone, :string
    end
  end
end
