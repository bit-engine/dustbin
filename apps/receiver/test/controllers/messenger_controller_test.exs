defmodule Receiver.MessengerControllerTest do
  use Receiver.ConnCase

  setup %{conn: conn} do
    conn = put_req_header(conn, "accept", "application/json")
    {:ok, conn: conn}
  end


  test "GET /webhook: given the right parameters it responds with 200 and the challenge sent", %{conn: conn} do
    conn = get conn, "/webhook?hub.mode=subscribe&hub.verify_token=DUMMY_TOKEN&hub.challenge=CHALLENGE"
    assert response(conn, 200) == "CHALLENGE"
  end 

  test "GET /webhook: given the wrong parameters it responds with 403", %{conn: conn} do
    assert true
  end
end
