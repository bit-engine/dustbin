defmodule Core.CollectionScheduleTest do
  use Core.Case

  @valid_attrs %{scheduled_date: "2017-01-01", utc_offset: "UTC-05:00"}
  @invalid_date %{scheduled_date: "random string", utc_offset: "UTC-05:00"}
  @invalid_attrs %{}

  test "changset with valid attributes" do
    changeset = CollectionSchedule.changeset(%CollectionSchedule{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invlid attributes" do
    changeset = CollectionSchedule.changeset(%CollectionSchedule{}, @invalid_attrs)
    refute changeset.valid?
  end

   test "changeset with invalid date" do
      changeset = CollectionSchedule.changeset(%CollectionSchedule{}, @invalid_date)
      refute changeset.valid?
   end
end
