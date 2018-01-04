defmodule Dustbin.APIWeb.LocationController do
  use Dustbin.APIWeb, :controller

  alias Dustbin.API.Schedules
  alias Dustbin.Data.Location

  action_fallback Dustbin.APIWeb.FallbackController

  def index(conn, %{"id" => id}) do
    with {:ok, collects} <- Schedules.get_collection_schedules_for_location(id, conn.query_params) do
      conn
      |> put_view(Dustbin.APIWeb.CollectionScheduleView)
      |> render(:index, collection_schedules: collects)
    end
  end
end
