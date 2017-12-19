defmodule Dustbin.Data.Model do
  @moduledoc """
  Keeps together the necessary `use`, `import` and `alias` statements needed by models.
  It overrides the default primary key and foreing key module attributes used by Ecto Schema
  if the `:schema` atom is specified.

  Usage

  `use Dustin.Data.Model`
  `use Dustbin.Data.Model, :schema`
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

      alias Dustbin.Data.{
        SupportedLocation,
        CollectionSchedule,
        Repo
      }
    end
  end

  def schema_key_spec do
    quote do
      use Ecto.Schema

      import Ecto.Changeset
      import Ecto.Query

      alias Dustbin.Data.{
        SupportedLocation,
        CollectionSchedule,
        Repo
      }

      @foreign_key_type :binary_id
      @primary_key {:id, :binary_id, autogenerate: true} 
    end
  end
end
