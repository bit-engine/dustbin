defmodule Dustbin.APIWeb.CollectionScheduleView do
  use Dustbin.APIWeb, :view
  alias Dustbin.APIWeb.CollectionScheduleView

  @collection_schedule_attrs ~w(id scheduled_date name type location_id)a
  @location_attrs ~w(id display_name timezone)a

  def render("index.json", %{collection_schedules: collection_schedules}) do
    %{
      collects: render_many(collection_schedules, __MODULE__, "show_item.json")
    }
  end

  def render("show_item.json", %{collection_schedule: collection_schedule}) do
    render_one(collection_schedule, __MODULE__, "collection_schedule.json")
  end

  def render("show.json", %{collection_schedule: collection_schedule}) do
    %{
      collect: render_one(collection_schedule, __MODULE__, "collection_schedule.json"),
    }
  end

  def render("collection_schedule.json", %{collection_schedule: collection_schedule}) do
    collection_schedule
    |> Map.take(@collection_schedule_attrs)
    |> Map.merge(%{location: render_one(collection_schedule.location, __MODULE__, "location.json", as: :location)})
  end

   def render("location.json", %{location: location}) do
    location
    |> Map.take(@location_attrs)    
   end
end
