defmodule Notifier.MessengerController do
	#require AI
	use Notifier.Web, :controller

	def webhook(conn, _params) do
		if conn.query_params["verify_token"] == System.get_env("FB_VERIFY_TOKEN")  do
			text conn, conn.query_params["challenge"]
		else
			send_resp(conn, 403, "Not Allowed")
		end
	end

	def receive(conn, _params) do
		if conn.body_params["object"] == "page" do
			allMessagesReceived =  Enum.reduce conn.body_params["entry"], [], fn entry, list ->
				pair = Enum.map entry["messaging"], fn ev ->
					%{:sender => ev["sender"]["id"], :text => ev["message"]["text"]}
				end
				list = list ++ pair
			end 
			Enum.map allMessagesReceived, fn pair ->
				%{sender: sender, text: text} = pair
				sendMessage(sender,text)
				#AI.sendMessage(sender,text)
			end
		end
		send_resp conn, 200, "" 
	end

	def sendMessage(userID, message) do
		response = HTTPotion.post(
			"https://graph.facebook.com/me/messages", 
			[
				query: %{"page_key": System.get_env("FB_ACCESS_TOKEN")}, 
				body: "{\"recipient\":{\"id\":\"#{userID}\"},\"message\":{\"text\":\"#{message}\"}}"
			]
		)
	end

end
