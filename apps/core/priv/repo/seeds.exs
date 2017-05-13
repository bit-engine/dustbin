defmodule Core.DBSeeder do
  alias Core.Repo
  alias Core.SupportedLocation
  alias Core.CollectType
  alias Core.CollectionSchedule
  alias NimbleCSV.RFC4180, as: CSV

  import Seedex

  require Logger

  @collect_types ["Recyclable Material", "Garbage", "Garbage & Bulky Waste", "Green Waste", "Natural Pine Tree", "Hazardous Household Waste", "Dry Material & Wood", "Electronic & Computer Equipment"]
  @data_path "#{__DIR__}/schedules/"

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
  
  @data_path <> "chambly_canada_2017.csv"
  |> File.read!
  |> CSV.parse_string
  |> Enum.each(fn [date, location, type] ->
    [city, country] = String.split(location, ",")
    %CollectType{id: collect_type_id} = Repo.get_by!(CollectType, type: type)
    %SupportedLocation{id: location_id} = Repo.get_by!(SupportedLocation, city: city, country: country)
    seed CollectionSchedule, fn schedule ->
      schedule
      |> Map.put(:scheduled_date, Ecto.Date.cast!(date))
      |> Map.put(:supported_location_id, location_id)
      |> Map.put(:collect_type_id, collect_type_id)
    end
  end)
end
