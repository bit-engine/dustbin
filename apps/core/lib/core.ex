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

  @doc """
  Returns true if the user is subscribed to Dustbin's notifications false otherwise
  """
  def is_subscribed?(user_id) do
    not (Repo.get_by(Subscription, user_id: "#{user_id}")
        |> is_nil)
  end

  @doc """
  Subscribes a user to Dustbin's notifications.
  This function will create an entry in subscriptions relation
  Serves as  wrapper on `Subscription.create/2`
  """
  def subscribe(user_id, location_id) do
    Subscription.create(user_id, location_id)
  end
end
