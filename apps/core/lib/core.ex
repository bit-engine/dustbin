defmodule Core do
  @moduledoc """
  Contains the all the logic and access to the information needed by other applications like Scheduler and AI.
  """
  use Core.Model

  @doc """
  Returns all the supported locations at the moment.
  """
  def supported_locations, do: Repo.all(SupportedLocation)
  
  @doc """
  Returns the next collects for a specific location.
  This function serves only as a wrapper around `CollectionSchedule.upcoming/1`
  """
  def upcoming_collects(location = %SupportedLocation{}) do
    CollectionSchedule.upcoming(location)
  end
end
