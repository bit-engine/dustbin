defmodule Dustbin.Data.CollectionSchedule do
  @moduledoc false

  use Dustbin.Data.Model, :schema
  use Timex
  
  @required_fields ~w(scheduled_date, name)
  @optional_fields ~w(details)

  schema "collection_schedules" do
    field :scheduled_date, :date
    field :name, :string
    field :details, :string
    belongs_to :location, Location
    timestamps()
  end

  def changeset(collection_schedule, params \\ %{}) do
    collection_schedule
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
