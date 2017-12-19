defmodule Core.Repo.Migrations.AddSubscriptionsTable do
  use Ecto.Migration

  def change do
	create table(:subscriptions, primary_key: false) do
		add :id, :uuid, primary_key: true
		add :user_id, :string
		add :supported_location_id, references(:supported_locations, type: :binary_id)
		add :collect_type_id, references(:collect_types, type: :binary_id)
		add :active, :boolean
		add :lang, :string		

		timestamps()
	end
	create index(:subscriptions, [:supported_location_id, :collect_type_id])

  end
end
