defmodule AI.ActionsTest do
  use ExUnit.Case

  alias Wit.Models.Response.Converse, as: WitConverse

  setup do
    {:ok, ai} = AI.start_link
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Core.Repo)
    on_exit fn ->
      assert_down ai
    end
  end

  test "verifies if a user is subscribed, no activation taken into account" do
    {session_id, _} = AI.create_session("999")
    %{not_subscribed: true} = AI.Actions.verify_subscription(session_id, %{}, nil) 

    Core.Repo.insert! %Core.Subscription{user_id: "1234"}
    {other_session_id, _} = AI.create_session("1234")
    %{is_subscribed: true} = AI.Actions.verify_subscription(other_session_id, %{}, nil)
  end

  test "creates quick replies from all the supported locations" do
    cities = ["Montreal,Canada", "San Francisco,United States", "Vancouver,Canada"]
    Enum.each(cities, fn city ->
      [city, country] = city |> String.split(",")
      Core.Repo.insert! %Core.SupportedLocation{city: city, country: country}
    end)
    quick_replies = [%{
      title: "Montreal, Canada",
      content_type: "text",
      payload: ""
    }, %{
      title: "San Francisco, United States",
      content_type: "text",
      payload: ""
    }, %{
      title: "Vancouver, Canada",
      content_type: "text",
      payload: ""
    }]
    %{quick_replies: ^quick_replies} = AI.Actions.create_quick_replies_from_locations(nil, %{}, nil)
  end

  test "given a city and a country, a check for location support is done" do
    location = Core.Repo.insert! %Core.SupportedLocation{city: "Montreal", country: "Canada"}
    message = %WitConverse{entities: %{"location" => [%{"value" => "#{location.city}, #{location.country}"}]}}
    location_string = "#{location.city}, #{location.country}"
    location_id = location.id
    %{location: ^location_string, location_supported: true, location_id: ^location_id} = AI.Actions.check_location_support(nil, %{}, message)
  end

  test "given a city and a country that are non existent or not supported context is updated" do 
    message = %WitConverse{entities: %{"location" => [%{"value" => "Random message"}]}}
    %{location: "Random message", location_not_supported: true} = AI.Actions.check_location_support(nil, %{}, message)
  
    some_other_message = %WitConverse{entities: %{"location" => [%{"value" => "Toronto, Canada"}]}}
    %{location: "Toronto, Canada", location_not_supported: true} = AI.Actions.check_location_support(nil, %{}, some_other_message)
  end

  test "performs a user subscription" do
    %Core.SupportedLocation{id: id} = Core.Repo.insert! %Core.SupportedLocation{city: "Montreal", country: "Canada"}
    context = %{"location_id" => id}
    {session_id, _} = AI.create_session("999")
    %{user_subscribed: true} = AI.Actions.subscribe(session_id, context, nil)
  end

  test "location validation on user subscription is performed" do
    context = %{"location_id" => "550e8400-e29b-41d4-a716-446655440000"}
    {session_id, _} = AI.create_session("999")
    %{user_not_subscribed: true} = AI.Actions.subscribe(session_id, context, nil)
  end
  
  defp assert_down(pid) do
    ref = Process.monitor(pid) 
    assert_receive {:DOWN, ^ref, _, _, _}
  end
end