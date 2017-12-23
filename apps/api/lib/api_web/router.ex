defmodule Dustbin.APIWeb.Router do
  use Dustbin.APIWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Dustbin.APIWeb do
    pipe_through :api
    
    resources "/collects", CollectionScheduleController, only: [:show]
  end
end
