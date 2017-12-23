defmodule Dustbin.Data.Location do
  @moduledoc false

  use Dustbin.Data.Model, :schema

  @fields ~w(slug, display_name, timezone)

  schema "locations" do
    field :slug, :string
    field :display_name, :string
    field :timezone, :string
    has_many :collection_schedules, CollectionSchedule
    timestamps()
  end

  def changeset(location, params \\ %{}) do
    location
    |> cast(params, @fields)
    |> validate_required(@fields)
  end
end
