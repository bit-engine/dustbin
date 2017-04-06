defmodule Receiver.Router do
  use Receiver.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Receiver do
    pipe_through :api

    get "/webhook", MessengerController, :webhook
    post "/webhook", MessengerController, :receive 
  end
	
end
