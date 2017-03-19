defmodule Core.SubscriptionTest do
  use Core.Case

  test "subscription id and foreign keys should be type uuid" do
    supported_location = insert(:supported_location)
    collect_type = insert(:collect_type)
    subscription = insert(
      :subscription,
      supported_location: supported_location
    )

    <<_::64, ?-, _::32, ?-, _::32, ?-, _::32, ?-, _::96>> = subscription.id
    <<_::64, ?-, _::32, ?-, _::32, ?-, _::32, ?-, _::96>> = subscription.supported_location_id

    assert subscription.supported_location_id == supported_location.id
  end

  test "create a subscription via Subscription.create/2" do
    location_id = insert(:supported_location).id
    {:ok, %Core.Subscription{supported_location_id: ^location_id, lang: "EN", active: true, user_id: "999"}} = Core.Subscription.create("999", location_id)
    {:error, _} = Core.Subscription.create("999", location_id)
  end
end