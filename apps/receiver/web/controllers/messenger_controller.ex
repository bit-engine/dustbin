defmodule Receiver.MessengerController do

  @moduledoc false
  @fb_verify_token Application.get_env(:receiver, :fb_verify_token)

	use Receiver.Web, :controller

  require Logger


	def webhook(conn, %{"hub.verify_token" => token, "hub.mode" => "subscribe", "hub.challenge" => challenge}) do
		if token == @fb_verify_token do
      Logger.info "Webhook successful"
			send_resp(conn, 200, challenge)
		else
      Logger.error "Webhook validation failed"
		  send_resp(conn, 403, "Not Allowed")
		end
	end

  def webhook(conn, _) do
    Logger.error "Incorrect parameters supplied to webhook"
		send_resp(conn, 403, "Incorrect parameters")
  end

  def receive(conn, %{"object" => "page", "entry" => entry}) do
    Enum.each(entry, fn %{"messaging" => messaging} -> 
      process_entry_messages(messaging)
    end)
    send_resp(conn, 200, "")
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
