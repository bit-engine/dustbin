defmodule Dustbin.API.Factory do
  use ExMachina.Ecto, repo: Dustbin.Data.Repo

  alias Dustbin.Data.CollectionSchedule
  alias Dustbin.Data.Location

  import Timex, only: [now: 1, to_date: 1, shift: 2]

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


  def collects_sequence(location = %Location{timezone: timezone}, opts \\ []) do
    today =
      timezone
      |> now()
      |> to_date()

    upcoming = Enum.reduce(1..(opts[:upcoming] || 2), [], fn(x, acc) ->
      [shift(today, days: x) | acc]
    end)
    past = Enum.reduce(1..(opts[:past] || 1), [], fn(x, acc) ->
      [shift(today, days: -x) | acc]
    end)

    past ++ upcoming
    |> Enum.map(fn date -> insert(:collection_schedule, scheduled_date: date, location: location) end)
  end
end
