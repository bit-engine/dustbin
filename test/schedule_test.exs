defmodule ScheduleTest do
  alias Dustbin.Schedule
  use ExUnit.Case

  defmodule EmptySchedules do
    use Schedule
  end

  defmodule DefinedSchedules do
    use Schedule

    schedule location_name: :foo, path: "test.json" 
  end

  defmodule InlineSchedules do
    use Schedule

    schedule location_name: :inline, inline: [
      %{
        "2018-01-01" => [
          %{"name" => "An inline test"}
        ]
      }
    ]
  end

  test "default find/2 should be defined when __using__ Schedule, which should return {:error, :not_found}" do
    assert {:error, :not_found} = EmptySchedules.find(:foo, "bar")
  end

  test "find/2 should be defined when __using__ Schedule, which should return {:ok, term} if schedules are defined" do
    assert {:ok, occurrences} = DefinedSchedules.find(:foo, "2018-01-02")
    assert [%{"name" => "foo"}, %{"name" => "bar"}] = occurrences
  end

  test "Schedule.schedule/1 macro should support inline arrays, creating find/2" do
    assert {:ok, occurrences} = InlineSchedules.find(:inline, "2018-01-01")
    assert [%{"name" => "An inline test"}] = occurrences
  end
end
