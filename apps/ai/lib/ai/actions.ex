defmodule AI.Actions do
  @moduledoc """
  This module defines wit custom actions
  """

  @temp "John Doe"
  alias Core.SupportedLocation
  alias Core.Repo
  alias Wit.Models.Response.Converse, as: WitConverse
  use Wit.Actions

  def say(session, context, message) do
    # Send Message to user in FB
  end

  def merge(session, context, %WitConverse{entities: %{"location" => [%{"value" => location} | _]}}) do
    Map.put(context, :location, Map.get(location, "value"))
  end

  def error(session, context, error) do
  end

  defaction verify_subscription(session, context, _message) do
    %{fbid: id} = AI.get_session(session)
    if Core.is_subscribed? id do
      Map.merge(context, %{susbscribed: true, username: @temp})
    else
      Map.merge(context, %{not_subscribed: true, username: @temp})
    end 
  end

  defaction create_quick_replies_from_locations(session, context, _message) do
    quick_replies = Enum.map(Core.supported_locations, fn %SupportedLocation{id: id, city: city, country: country} ->
      %{title: "#{city}, #{country}", content_type: "text", payload: id}
    end) 
    Map.put(context, :quick_replies, quick_replies)  
  end

  defaction check_location_support(session, context, %WitConverse{entities: %{"location" => [%{"value" => location} | _]}}) do
    location_value = Map.get(location, "value")
    [city, country] = String.split(location_value, ",")

    case Repo.get_by(SupportedLocation, city: city, country: country) do
      %SupportedLocation{} -> Map.merge(context, %{location: location_value, location_supported: true})
      nil -> Map.merge(context, %{location: location_value, location_not_supported: true})
    end
  end
end
