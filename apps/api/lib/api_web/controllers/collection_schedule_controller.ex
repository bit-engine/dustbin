defmodule Dustbin.APIWeb.CollectionScheduleController do
  use Dustbin.APIWeb, :controller

  alias Dustbin.API.Schedules
  alias Dustbin.Data.CollectionSchedule

  action_fallback Dustbin.APIWeb.FallbackController

  def show(conn, %{"id" => id}) do
    collection_schedule = API.Schedules.get_collection_schedule!(id)
    render(conn, "show.json", collection_schedule: collection_schedule)
  end
end
