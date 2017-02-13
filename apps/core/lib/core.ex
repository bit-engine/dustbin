defmodule Core do
  use Core.Model

  def supported_locations, do: Repo.all(SupportedLocation)
end
