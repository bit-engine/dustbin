defmodule Core.Factory do
  @moduledoc """
  Defines required factories in tests
  """

  use ExMachina.Ecto, repo: Core.Repo

  alias Core.{
    CollectType,
    SupportedLocation,
    CollectionSchedule,
    Subscription
  }


  def collection_schedule_factory do
    %CollectionSchedule{
      scheduled_date: ~D[2017-01-01],
      collect_type: build(:collect_type),
      supported_location: build(:supported_location)
    }
  end

  def collect_type_factory do
    %CollectType{
      type: "Trash"
    }
  end

  def supported_location_factory do
    %SupportedLocation{}
  end

  def subscription_factory do
    %Subscription{
      supported_location: build(:supported_location),
      collect_type: build(:collect_type),
      user_id: "9999",
      active: true,
      lang: "en"
    }
  end
end
