defmodule Notifier.Router do
  use Notifier.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Notifier do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", Notifier do
    pipe_through :api

    get "/webhook", MessengerController, :webhook
    post "/webhook", MessengerController, :receive 
  end
	

  # Other scopes may use custom stacks.
  # scope "/api", Notifier do
  #   pipe_through :api
  # end
end
