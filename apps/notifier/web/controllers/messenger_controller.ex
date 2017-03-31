defmodule Notifier.MessengerController do

  @moduledoc false
  @fb_token System.get_env("FB_VERIFY_TOKEN")

	use Notifier.Web, :controller

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


	def receive(conn, _params) do
		if conn.body_params["object"] == "page" do
			all_messages_received =  Enum.reduce conn.body_params["entry"], [], fn entry, list ->
				pair = Enum.map entry["messaging"], fn ev ->
					%{:sender => ev["sender"]["id"], :text => ev["message"]["text"]}
				end
				list = list ++ pair
			end 
			Enum.map all_messages_received, fn pair ->
				%{sender: sender, text: text} = pair
				send_message(sender,text)
				#AI.sendMessage(sender,text)
			end
		end
		send_resp conn, 200, "" 
	end

	def send_message(userID, message) do
		_response = HTTPotion.post(
			"https://graph.facebook.com/me/messages", 
			[
				query: %{"page_key": System.get_env("FB_ACCESS_TOKEN")}, 
				body: "{\"recipient\":{\"id\":\"#{userID}\"},\"message\":{\"text\":\"#{message}\"}}"
			]
		)
	end

end
