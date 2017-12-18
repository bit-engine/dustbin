defmodule Dustbin.Data.CollectionScheduleRepoTest do
  use Dustbin.Data.Case
  use Timex

  test "given a location upcoming/1 should return any collection scheduled for the next day" do
    chambly = SupportedLocation.location_for_slug("chambly")
    expected = insert(:collection_schedule, scheduled_date: tomorrow(chambly.timezone))
    insert(:collection_schedule, scheduled_date: today(chambly.timezone))
    insert(:collection_schedule, scheduled_date: yesterday(chambly.timezone))
    
    # Core.upcoming_collects/1 should be equivalent to CollectionSchedule.upcoming/1
    # so by doing the following, we're testing both
    result =
      "chambly"
      |> Dustbin.Data.upcoming_collects
      |> Enum.at 0

    assert result.id == expected.id
    assert result.scheduled_date == expected.scheduled_date
    assert result.name == expected.name
  end

  test "given no collections schedules for the next day, upcoming/1 should return []" do
    chambly = SupportedLocation.location_for_slug("chambly")
    day_after_tomorrow = Timex.shift(tomorrow(chambly.timezone), days: 1)
    insert(:collection_schedule, scheduled_date: day_after_tomorrow)
    insert(:collection_schedule, scheduled_date: yesterday(chambly.timezone))
    
    # Core.upcoming_collects/1 should be equivalent to CollectionSchedule.upcoming/1
    # so by doing the following, we're testing both
    result = Dustbin.Data.upcoming_collects("chambly")
    assert Enum.empty? result
  end

  defp today(timezone) do
    Timex.now(timezone)
    |> Timex.to_date
  end

  defp tomorrow(timezone) do
    Timex.now(timezone)
    |> Timex.to_date
    |> Timex.shift(days: 1)
  end

  defp yesterday(timezone) do
    Timex.now(timezone)
    |> Timex.to_date
    |> Timex.shift(days: -1)
  end
end
