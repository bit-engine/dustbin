defmodule Core.SupportedLocation do
  @moduledoc false

  use Core.Model, :schema

  @fields [:city, :province_or_state, :country, :country_code, :timezone] 

  schema "supported_locations" do
    field :city, :string
    field :province_or_state, :string
    field :country, :string
    field :country_code, :string
    field :timezone, :string
    has_many :collection_schedules, CollectionSchedule
    
    timestamps()
  end

  def changeset(supported_location, params \\ %{}) do
    supported_location
    |> cast(params, @fields)
    |> validate_required(@fields)
  end
end
