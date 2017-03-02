defmodule AITest do
  use ExUnit.Case

  setup do
    {:ok, ai} = AI.start_link()

    on_exit fn ->
      assert_down ai
    end
  end

  test "AI should create a new sesssion for a sender that doesn't has one" do
    sender = "12345"
    {session_id, %{context: %{}, fbid: ^sender}} = AI.create_session sender
  end

  test "AI should not create a session when a sender has a existing valid one" do
    state = %{"some-session-id" => %{fbid: 123, context: %{}}}
    {:reply, result, new_state} = AI.handle_call({:create_session, 123}, AI, state)

    assert result == {"some-session-id", %{fbid: 123, context: %{}}}
    assert new_state == state
  end 

  defp assert_down(pid) do
    ref = Process.monitor(pid) 
    assert_receive {:DOWN, ^ref, _, _, _}
  end
end
