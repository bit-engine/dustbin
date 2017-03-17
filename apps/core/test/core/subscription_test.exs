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
end
