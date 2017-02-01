defmodule Core.CollectionSchedule do
  use Core.Model
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

  def upcoming(%SupportedLocation{} = location) do
    tomorrow = Timex.now(location.timezone) |> Timex.to_date |> Timex.shift(days: 1)
    location_schedules = assoc(location, :collection_schedules)
    
    upcoming = from sch in location_schedules,
      where: sch.scheduled_date == ^tomorrow,
      preload: [:collect_type]

    Repo.all upcoming
  end
end
