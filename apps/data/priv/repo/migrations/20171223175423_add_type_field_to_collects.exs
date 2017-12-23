defmodule Dustbin.Data.Repo.Migrations.AddTypeFieldToCollects do
  use Ecto.Migration

  def change do
    alter table(:collection_schedules) do
      add :type, :string
    end
  end
end
