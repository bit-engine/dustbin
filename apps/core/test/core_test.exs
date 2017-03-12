defmodule CoreTest do
  use Core.Case

  test "supported_locations/0 returns all the existent locations" do
    insert(:supported_location, city: "Montreal", timezone: "America/Toronto")
    insert(:supported_location, city: "Toronto", timezone: "America/Toronto")
    insert(:supported_location, city: "Buenos Aires", timezone: "America/Argentina/Buenos_Aires")

    result = Core.supported_locations
    assert length(result) == 3
  end

  test "returns if a user_is is subscribed" do
    insert(:subscription, user_id: "1234")
    assert Core.is_subscribed? "1234"
    refute Core.is_subscribed? "456"
  end
end
