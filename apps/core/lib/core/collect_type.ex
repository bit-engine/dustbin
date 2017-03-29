defmodule Core.CollectType do 
  @moduledoc false

  use Core.Model, :schema
  
  schema "collect_types" do
    field :type, :string
    has_many :collection_schedules, CollectionSchedule

    timestamps()
  end

  def changeset(collect_type, params \\ %{}) do
    collect_type
    |> cast(params, [:type])
    |> validate_required([:type])
    |> unique_constraint(:type)
  end
end
