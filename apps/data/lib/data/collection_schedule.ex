defmodule Dustbin.Data.CollectionSchedule do
  @moduledoc false

  use Dustbin.Data.Model, :schema
  use Timex
  
  import Ecto, only: [assoc: 2]

  @fields ~w(scheduled_date, type, name)

  schema "collection_schedules" do
    field :scheduled_date, :date
    field :name, :string
    field :type, :string
    belongs_to :location, Location
    timestamps()
  end

  def changeset(collection_schedule, params \\ %{}) do
    collection_schedule
    |> cast(params, @fields)
    |> validate_required(@fields)
  end

  @doc """
  Returns the next collects for a specific location.
  This function will query the database and look for all entries where the scheduled date
  equals exactly one day after today's date in the location's timezone. 
  """
  # def upcoming(location_slug) do
  #   # TODO: throw eror if location slug is invalid?
  #   location = SupportedLocation.location_for_slug(location_slug)
  #   upcoming = from sch in CollectionSchedule,
  #     where: sch.location_slug == ^location_slug and sch.scheduled_date == ^tomorrow(location.timezone)

  #   Repo.all upcoming
  # end

  defp tomorrow(timezone) do
    Timex.now(timezone)
    |> Timex.to_date
    |> Timex.shift(days: 1)
  end
end
