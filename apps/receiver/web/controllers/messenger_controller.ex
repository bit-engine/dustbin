defmodule Receiver.MessengerController do

  @moduledoc false
  @fb_token System.get_env("FB_VERIFY_TOKEN")

	use Receiver.Web, :controller

  require Logger



	def webhook(conn, %{"hub.verify_token" => token, "hub.mode" => "subscribe"}) do
		if token == @fb_token do
      Logger.info "Webhook successful"
			send_resp(conn, 200, conn.query_params["challenge"])
		else
      webhook(conn, nil)
		end
	end

  def webhook(conn, _params) do
    Logger.error "Webhook validation failed"
		send_resp(conn, 403, "Not Allowed")
  end


  def receive(conn, %{"object" => "page", "entry" => entry}) do
    Enum.each(entry, fn %{"messaging" => messaging} -> 
      process_entry_messages(messaging)
    end)
    send_resp(conn, :ok, "")
  end

  defp process_entry_messages(messaging) do
    Enum.each(messaging, fn messaging_evt ->
      if Map.has_key?(messaging_evt, "message") do
        %{"message" => %{"text" => text}, "sender" => %{"id" => uid}} = messaging_evt
        AI.process(text, uid)
      end
    end)
  end
end
