defmodule Core.Model do

  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
      import Ecto.Query

      alias Core.{
        CollectType,
        SupportedLocation,
        CollectionSchedule,
        Repo
      }
      @primary_key {:id, :binary_id, autogenerate: true} 
      @foreign_key_type :binary_id
    end
  end
end
