defmodule Core.DBSeeder do
  alias Core.Repo
  alias Core.SupportedLocation
  alias Core.CollectType
  alias Core.CollectionSchedule

  import Seedex

  require Logger

  @collect_types ["Recyclable Material", "Garbage", "Garbage & Bulky Waste", "Green Waste", "Natural Pine Tree", "Hazardous Household Waste", "Dry Material & Wood", "Electronic & Computer Equipment"]

  # seed collect types
  for type <- @collect_types, do: seed CollectType, fn collect_type -> %{collect_type | type: type} end

  # seed supported locations:
  # initially only supporting chambly
  seed SupportedLocation, fn location ->
    location
    |> Map.put(:city, "Chambly")
    |> Map.put(:province_or_state, "Quebec")
    |> Map.put(:country, "Canada")
    |> Map.put(:country_code, "CA")
    |> Map.put(:timezone, "America/Toronto")
  end
  
  # seed collects aka Collection Schedules for supported locations

  # Chambly
  
end
