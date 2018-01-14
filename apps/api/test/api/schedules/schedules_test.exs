defmodule Dustbin.API.SchedulesTest do

  use Dustbin.APIWeb.DataCase

  alias Dustbin.API.Schedules
  alias Dustbin.Data.CollectionSchedule
  alias Dustbin.Data.Location


  describe "Collection Schedules" do 
    test "it returns a collect given a specific :id" do
      collect = insert(
        :collection_schedule,
        location: insert(:location)
      )
      
      {:ok, result} = Schedules.get_collection_schedule(collect.id)
      assert %CollectionSchedule{} = collect
      assert result.id == collect.id
      assert %Location{} = collect.location
    end

    test "it returns {:error, :not_found} when trying to access a non-existent collect" do
      insert(:collection_schedule)
      assert {:error, :not_found} = Schedules.get_collection_schedule Ecto.UUID.generate
      assert {:error, :not_found} = Schedules.get_collection_schedule "foo"
    end
  end

  describe "Locations" do
    test "it returns the upcoming collection schedules for a specific location when no filter given" do
      location = insert(:location)
      today = Timex.to_date(Timex.now(location.timezone))
      yesterday = Timex.shift(today, days: -1)
      tomorrow = Timex.shift(today, days: 1)

      Enum.each([yesterday, today, tomorrow], fn date ->
        insert(
          :collection_schedule,
          scheduled_date: date,
          location: location
        ) 
      end)
      
      {:ok, results} = Schedules.get_collection_schedules_for_location(location.id, %{})
      assert length(results) == 2

      Enum.each(results, fn r ->
        assert r.location_id == location.id
        assert Date.compare(r.scheduled_date, yesterday) == :gt
      end)
    end

    test "it returns all the collection schedules for a location  when the all filter is given" do
      location = insert(:location, slug: "nyc")
      insert_list(5, :collection_schedule, location: location)
      insert(:collection_schedule)

      {:ok, results} = Schedules.get_collection_schedules_for_location(location.id, %{"filter" => "all"})

      assert length(results) == 5
    end

    test "it returns {:error, {:bad_request, details}} when an unknown filter is given" do
      location = insert(:location)
      {:error, {:bad_request, _}} = Schedules.get_collection_schedules_for_location(location.id, %{"filter" => "foo"})
    end

    test "it returns {:error, :not_found} when an unesxistent location id is given" do
      {:error, :not_found} = Schedules.get_collection_schedules_for_location("foo", %{})
    end
  end
end
