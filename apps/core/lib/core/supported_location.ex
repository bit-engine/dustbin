defmodule Core.SupportedLocation do
  use Core.Model

  @fields [:city, :province_or_state, :country, :country_code] 
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "supported_locations" do
    field :city, :string
    field :province_or_state, :string
    field :country, :string
    field :country_code, :string
    has_many :collection_schedules, CollectionSchedule
    
    timestamps()
  end

  def changeset(supported_location, params \\ %{}) do
    supported_location
    |> cast(params, @fields)
    |> validate_required(@fields)
  end
end
