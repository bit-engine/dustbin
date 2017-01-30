defmodule Core.CollectionSchedule do
  use Core.Model

  @fields [:scheduled_date, :utc_offset]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "collection_schedules" do
    field :scheduled_date, :date
    field :utc_offset, :string
    belongs_to :supported_location, SupportedLocation
    belongs_to :collect_type, CollectType
    
    timestamps()
  end

  def changeset(collection_schedule, params \\ %{}) do
    collection_schedule
    |> cast(params, @fields)
    |> validate_required(@fields)
  end
end
