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
    |> validate_required(@fields ++ [:supported_location_id])
    |> unique_constraint(:user_id)
    |> foreign_key_constraint(:supported_location_id)
  end

  def subscribed?(user_id) do
    q = from s in Subscription,
          where: s.user_id == ^user_id and s.active == true

    result = Repo.one(q)
    not is_nil(result)
  end

  def create(user_id, location_id) do
    location = Repo.get(SupportedLocation, location_id)
    params = %{user_id: user_id, active: true, lang: "EN"}
    changeset = 
      location
      |> Ecto.build_assoc(:subscriptions)
      |> changeset(params)
    Repo.insert changeset
  end

  def deactivate(user_id) do
    subscription = Repo.get_by(Subscription, user_id: user_id)
    subscription = change(subscription, active: false)
    Repo.update subscription
  end
end
