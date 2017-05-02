defmodule Core.DBSeeder do
  alias Core.Repo
  alias Core.SupportedLocation
  alias Core.CollectType
  alias Core.CollectionSchedule

  Repo.delete_all SupportedLocation
  Repo.delete_all CollectType
  Repo.delete_all CollectionSchedule

  chambly = Repo.insert! %SupportedLocation{
    city: "Chambly",
    province_or_state: "Quebec",
    country: "Canada",
    country_code: "CA",
    timezone: "America/Toronto"
  }

  trash = Repo.insert! %CollectType{
    type: "Trash"
  }

  Repo.insert! %CollectionSchedule{
    scheduled_date: Ecto.Date.cast!("2017-05-02"),
    supported_location_id: chambly.id,
    collect_type_id: trash.id
  } 
end
