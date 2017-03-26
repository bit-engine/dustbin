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
    # Must check for quick replies here if any in context
  end

  def merge(session, context, %WitConverse{entities: %{"location" => [%{"value" => location} | _]}}) do
    Map.put(context, :location, Map.get(location, "value"))
  end

  def error(session, context, error) do
  end

  defaction verify_subscription(session, context, _message) do
    %{fbid: id} = AI.get_session(session)
    if Core.subscribed? id do
      Map.merge(context, %{is_subscribed: true, username: @temp})
    else
      Map.merge(context, %{not_subscribed: true, username: @temp})
    end 
  end

  defaction create_quick_replies_from_locations(_session, context, _message) do
    quick_replies = Enum.map(Core.supported_locations, fn %SupportedLocation{id: id, city: city, country: country} ->
      %{title: "#{city}, #{country}", content_type: "text", payload: ""}
    end) 
    Map.put(context, :quick_replies, quick_replies)  
  end

  # TODO
  # - Remove direct repo access
  defaction check_location_support(_session, context, %WitConverse{entities: %{"location" => [%{"value" => location} | _]}}) do
    case String.split(location, ~r{, }) do
      [city, country] ->
        case Repo.get_by(SupportedLocation, city: city, country: country) do
          %SupportedLocation{id: id} -> Map.merge(context, %{location: location, location_supported: true, location_id: id})
          nil -> Map.merge(context, %{location: location, location_not_supported: true})
        end
      _ ->
        Map.merge(context, %{location: location, location_not_supported: true})
    end
  end

  defaction subscribe(session, context, _message) do
    location_id = Map.get(context, "location_id")
    %{fbid: user_id} = AI.get_session(session)
    case Core.subscribe(user_id, location_id) do
      {:ok, _} -> Map.merge(context, %{user_subscribed: true})
      {:error, _} -> Map.merge(context, %{user_not_subscribed: true})
    end
  end

  defaction unsubscribe(session, context, _message) do
    %{fbid: user_id} = AI.get_session(session)
    case Core.unsubscribe(user_id) do
      {:ok, _} -> Map.merge(context, %{unsubscribed: true, username: @temp})
      {:error, _} -> Map.merge(context, %{not_unsubscribed: true})
    end
  end

  defaction end_conversation(_session, context, _message) do
    Map.put(context, :done, true)
  end
end
