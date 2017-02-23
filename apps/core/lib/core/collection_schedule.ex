defmodule Core.CollectionSchedule do
  use Core.Model, :schema
  import Ecto, only: [assoc: 2]
  use Timex

  @fields [:scheduled_date]

  schema "collection_schedules" do
    field :scheduled_date, :date
    belongs_to :supported_location, SupportedLocation
    belongs_to :collect_type, CollectType
    
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
  def upcoming(%SupportedLocation{} = location) do
    location_schedules = assoc(location, :collection_schedules) 
    upcoming = from sch in location_schedules,
      where: sch.scheduled_date == ^tomorrow(location.timezone),
      preload: [:collect_type]

    Repo.all upcoming
  end

  defp tomorrow(timezone) do
    Timex.now(timezone)
    |> Timex.to_date
    |> Timex.shift(days: 1)
  end
end
