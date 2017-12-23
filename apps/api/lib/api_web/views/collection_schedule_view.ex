defmodule Dustbin.APIWeb.CollectionScheduleView do
  use Dustbin.APIWeb, :view
  alias Dustbin.APIWeb.CollectionScheduleView

  def render("show.json", %{collection_schedule: collection_schedule}) do
    %{data: render_one(collection_schedule, CollectionScheduleView, "collection_schedule.json")}
  end

  def render("collection_schedule.json", %{collection_schedule: collection_schedule}) do
    collection_schedule
  end
end
