defmodule Core.Factory do
  use ExMachina.Ecto, repo: Core.Repo

  alias Core.{
    CollectType,
    SupportedLocation,
    CollectionSchedule,
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
end
