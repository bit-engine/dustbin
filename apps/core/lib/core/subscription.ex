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
    |> unique_constraint(:user_id)
    |> foreign_key_constraint(:supported_location_id)
  end

  def create(user_id, location_id) do
    params = %{user_id: user_id, active: true, lang: "EN"}
    changeset = changeset(%Subscription{supported_location_id: location_id}, params)
    Repo.insert changeset
  end
end
