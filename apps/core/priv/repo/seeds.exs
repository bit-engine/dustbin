defmodule Core.DBSeeder do
  alias Core.Repo
  alias Core.SupportedLocation
  alias Core.CollectType
  alias Core.CollectionSchedule

  import Seedex

  require Logger

  @collect_types ["Recyclable Material", "Garbage", "Bulky Garbage", "Green Waste", "Natural Pine Tree", "Hazardous Household Waste", "Wood", "Electronic & Computer Equipment"]

  # seed collect types
  for type <- @collect_types, do: seed CollectType, fn collect_type -> %{collect_type | type: type} end

end
