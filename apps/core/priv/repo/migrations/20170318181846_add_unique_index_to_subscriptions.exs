defmodule Core.Repo.Migrations.AddUniqueIndexToSubscriptions do
  use Ecto.Migration

  def change do
    create unique_index(:subscriptions, [:user_id])
  end
end
