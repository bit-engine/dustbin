defmodule Receiver.Router do
  use Receiver.Web, :router

  pipeline :hooks do
    plug :accepts, ["json"]
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", Receiver do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/hooks", Receiver do
    pipe_through :hooks

    get "/webhook", MessengerController, :webhook
    post "/webhook", MessengerController, :receive 
  end
	
end
