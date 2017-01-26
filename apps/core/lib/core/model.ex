defmodule Core.Model do

  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
      import Ecto.Query

      alias Core.{
        CollectType,
        SupportedLocation,
        Repo
      }
    end
  end
end
