defmodule Dustbin.Data.Factory do
  @moduledoc """
  Defines required factories in tests
  """

  use ExMachina.Ecto, repo: Dustbin.Data.Repo

  alias Dustbin.Data.{
    SupportedLocation,
    CollectionSchedule,
  }


  def collection_schedule_factory do
    %CollectionSchedule{
      scheduled_date: ~D[2017-01-01],
      location_slug: "chambly", 
      name: "Ordures"
    }
  end
end
