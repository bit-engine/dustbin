defmodule Dustbin.Data do
  @moduledoc """
  Contains the all the logic and access to the information needed by other applications like Scheduler and AI.
  """
  use Dustbin.Data.Model

  @doc """
  Returns all the supported locations.
  """
  def supported_locations, do: SupportedLocation.all
  
  @doc """
  Returns the next collects for a specific location (slug)
  This function serves only as a wrapper around `CollectionSchedule.upcoming/1`
  """
  def upcoming_collects(location_slug) do
    CollectionSchedule.upcoming(location_slug)
  end
end
