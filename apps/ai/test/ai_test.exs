defmodule AITest do
  use ExUnit.Case

  test "AI should create a new sesssion for a sender that doesn't has one" do
    sender = "12345"
    {session_id, %{context: %{}, fbid: ^sender}} = AI.create_session sender
  end
end
