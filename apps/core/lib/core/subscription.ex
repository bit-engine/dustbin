defmodule Core.Subscription do
  @moduledoc false 

  use Core.Model, :schema

  @fields [:user_id, :active, :lang]

  schema "subscriptions" do
    field :user_id, :string
    field :active, :boolean
    field :lang, :string
    belongs_to :supported_location, SupportedLocation

    timestamps()
  end

  def changeset(subscription, params \\ %{}) do
    subscription
    |> cast(params, @fields)
    |> validate_required(@fields)
  end

end
