defmodule Core.CollectType do 
  use Core.Model
  
  @primary_key {:id, :binary_id, autogenerate: true}
  schema "collect_types" do
    field :type, :string

    timestamps()
  end

  def changeset(collect_type, params \\ %{}) do
    collect_type
    |> cast(params, [:type])
    |> validate_required([:type])
    |> unique_constraint(:type)
  end
end
