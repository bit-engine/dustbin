defmodule Core.SuppotedLocationTest do
  use Core.Case

  @valid_attrs %{
    city: "Buenos Aires",
    province_or_state: "Buenos Aires",
    country: "Argentina",
    country_code: "AR"
  }

  test "changeset with valid attributes" do
    changeset = SupportedLocation.changeset(%SupportedLocation{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = SupportedLocation.changeset(%SupportedLocation{}, %{})
    refute changeset.valid?
  end
end
