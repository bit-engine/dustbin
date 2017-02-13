defmodule Core.DBSeeder do
  alias Core.Repo
  alias Core.SupportedLocation

  Repo.delete_all SupportedLocation

  Repo.insert! %SupportedLocation{
    city: "Chambly",
    province_or_state: "Quebec",
    country: "Canada",
    country_code: "CA",
    timezone: "America/Toronto"
  }
end
