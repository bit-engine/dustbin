defmodule Dustbin.API.Factory do
  use ExMachina.Ecto, repo: Dustbin.Data.Repo

  alias Dustbin.Data.CollectionSchedule
  alias Dustbin.Data.Location

  def location_factory do
    %Location{
      slug: "chambly",
      display_name: "Chambly, Canada",
      timezone: "America/Montreal", 
    }
  end

  def collection_schedule_factory do
    %CollectionSchedule{
      name: "Waste",
      scheduled_date: "2018-01-08",
      type: "Waste",
      location: build(:location),
    }
  end
end
