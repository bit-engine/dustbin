defmodule Core.Model do
  @moduledoc """
  Keeps together the necessary `use`, `import` and `alias` statements needed by models.
  It overrides the default primary key and foreing key module attributes used by Ecto Schema
  if the `:schema` atom is specified.

  Usage

  `use Core.Model`
  `use Core.Model, :schema`
  """

  defmacro __using__(:schema) do
    schema_key_spec()
  end

  defmacro __using__(_) do
    default()
  end

  def default do
    quote do
      use Ecto.Schema

      import Ecto.Changeset
      import Ecto.Query

      alias Core.{
        CollectType,
        SupportedLocation,
        CollectionSchedule,
        Subscription,
        Repo
      }
    end
  end

  def schema_key_spec do
    quote do
      use Ecto.Schema

      import Ecto.Changeset
      import Ecto.Query

      alias Core.{
        CollectType,
        SupportedLocation,
        CollectionSchedule,
        Subscription,
        Repo
      }

      @foreign_key_type :binary_id
      @primary_key {:id, :binary_id, autogenerate: true} 
    end
  end
end
