defmodule Dustbin.API.SchedulesTest do

  use Dustbin.APIWeb.DataCase

  alias Dustbin.API.Schedules

  describe "Collection Schedules" do
    alias Dustbin.Data.CollectionSchedule
    alias Dustbin.Data.Location

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
end
