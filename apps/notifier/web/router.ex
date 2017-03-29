defmodule Notifier.Router do
  use Notifier.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Notifier do
    pipe_through :api

    get "/webhook", MessengerController, :webhook
    post "/webhook", MessengerController, :receive 
  end
	
end
