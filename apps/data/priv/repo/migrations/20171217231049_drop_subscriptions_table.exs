defmodule Core.Repo.Migrations.DropSubscriptionsTable do
  use Ecto.Migration

  def change do
    drop table(:subscriptions)
  end
end
