defmodule Core.DBSeeder do
  alias Core.Repo
  alias Core.SupportedLocation
  alias Core.CollectType
  alias Core.CollectionSchedule

  import Seedex

  require Logger

  @collect_types ["Recyclable Material", "Garbage", "Bulky Garbage", "Green Waste", "Natural Pine Tree", "Hazardous Household Waste", "Wood", "Electronic & Computer Equipment"]

  Enum.each(@collect_types, fn type -> 
    seed CollectType, fn collect_type ->
      %{collect_type | type: type}
    end
  end)

end
