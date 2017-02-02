defmodule Core.CollectionScheduleRepoTest do
  use Core.Case
  use Timex

  test "collection schedule id and foreign keys should be type uuid" do
    collect_type = insert(:collect_type)
    location = insert(:supported_location)
    schedule = insert(
      :collection_schedule,
      collect_type: collect_type,
      supported_location: location
    )
    
    <<_::64, ?-, _::32, ?-, _::32, ?-, _::32, ?-, _::96>> = schedule.id
    <<_::64, ?-, _::32, ?-, _::32, ?-, _::32, ?-, _::96>> = schedule.collect_type_id
    <<_::64, ?-, _::32, ?-, _::32, ?-, _::32, ?-, _::96>> = schedule.supported_location_id

    assert schedule.collect_type_id == collect_type.id
    assert schedule.supported_location_id == location.id
  end

  test "given a location upcoming/1 should return any collection scheduled for the next day" do
    collect_type = insert(:collect_type)
    montreal = insert(:supported_location, city: "Montreal", timezone: "America/Toronto")
    expected = insert(:collection_schedule, scheduled_date: tomorrow(montreal.timezone), collect_type: collect_type, supported_location: montreal)
    insert(:collection_schedule, scheduled_date: today(montreal.timezone), collect_type: collect_type, supported_location: montreal)
    insert(:collection_schedule, scheduled_date: yesterday(montreal.timezone), collect_type: collect_type, supported_location: montreal)
    
    result = List.first(CollectionSchedule.upcoming(montreal))
    assert result.id == expected.id
    assert result.scheduled_date == expected.scheduled_date
    assert result.id == expected.id
  end

  test "given no collections schedules for the next day, upcoming/1 should return []" do
    collect_type = insert(:collect_type)
    montreal = insert(:supported_location, city: "Montreal", timezone: "America/Toronto")
    day_after_tomorrow = Timex.shift(tomorrow(montreal.timezone), days: 1)
    insert(:collection_schedule, scheduled_date: day_after_tomorrow, collect_type: collect_type, supported_location: montreal)
    insert(:collection_schedule, scheduled_date: yesterday(montreal.timezone), collect_type: collect_type, supported_location: montreal)
    
    assert CollectionSchedule.upcoming(montreal) == []
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
