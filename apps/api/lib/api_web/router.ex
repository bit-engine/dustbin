defmodule Dustbin.APIWeb.Router do
  use Dustbin.APIWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug Dustbin.API.Locale
  end

  scope "/", Dustbin.APIWeb do
    pipe_through :api
    
    resources "/collects", CollectionScheduleController, only: [:show]
    get "/locations/:id/collects", LocationController, :index, as: :location_collects
  end
end
