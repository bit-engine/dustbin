defmodule Dustbin.Data.SuppotedLocationTest do
  use Dustbin.Data.Case

  test "SupportedLocation.location_for_slug/1 returns location data for a valid location slug" do
    assert SupportedLocation.location_for_slug("chambly") == %{
     :slug => "chambly",
     :city => "Chambly",
     :province => "Quebec",
     :country_code => "CA",
     :timezone => "America/Montreal"
   }
  end

  test "SupportedLocation.location_for_slug/1 returns nil for an unknown location slug" do
    assert SupportedLocation.location_for_slug("foo") == nil
  end

  test "SupportedLocation.all/0 should return all supported locations" do
    assert SupportedLocation.all === [
      %{
         :slug => "chambly",
         :city => "Chambly",
         :province => "Quebec",
         :country_code => "CA",
         :timezone => "America/Montreal"
       }
    ]
  end
end
