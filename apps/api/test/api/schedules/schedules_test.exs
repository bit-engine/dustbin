defmodule Dustbin.API.SchedulesTest do

  use Dustbin.APIWeb.DataCase

  alias Dustbin.API.Schedules

  describe "Collection Schedules" do
    alias Dustbin.Data.CollectionSchedule
    alias Dustbin.Data.Location

    test "it returns a collect when searching it via an existing :id" do
      collect = insert(
        :collection_schedule,
        location: insert(:location)
      )
      
      {:ok, result} = Schedules.get_collection_schedule!(collect.id)
      assert %CollectionSchedule{} = collect
      assert result.id == collect.id
      assert %Location{} = collect.location
    end

    test "it should return {:error, :not_found} when trying to access a non-existent collect" do
    end
  end
end
