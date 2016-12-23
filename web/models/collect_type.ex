defmodule Dustbin.CollectType do
  use Dustbin.Web, :model

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "collect_types" do
    field :name, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
