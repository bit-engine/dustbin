defmodule Core.Subscription do
  use Core.Model, :schema

  @fields [:user_id, :active, :lang]

  schema "subscriptions" do
    field :user_id, :string
    field :active, :boolean
    field :lang, :string
    belongs_to :supported_location, SupportedLocation
    belongs_to :collect_type, CollectType

    timestamps()
  end

  def changeset(subscription, params \\ %{}) do
    subscription
    |> cast(params, @fields)
    |> validate_required(@fields)
  end

end
