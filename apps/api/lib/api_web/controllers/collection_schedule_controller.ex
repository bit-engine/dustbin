defmodule Dustbin.APIWeb.CollectionScheduleController do
  use Dustbin.APIWeb, :controller

  alias Dustbin.API.Schedules

  action_fallback Dustbin.APIWeb.FallbackController

  def show(conn, %{"id" => id}) do
    with {:ok, collect} <- Schedules.get_collection_schedule(id) do
      render(conn, "show.json", collection_schedule: collect)
    end
  end
end
