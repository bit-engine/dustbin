defmodule AI.ActionsTest do
  use ExUnit.Case

  setup do
    {:ok, ai} = AI.start_link
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Core.Repo)
    on_exit fn ->
      assert_down ai
    end
  end

  test "verifies if a user is subscribed, no activation taken into account" do
    {session_id, _} = AI.create_session("999")
     %{not_subscribed: true} = AI.Actions.verify_subscription(session_id, %{}, nil) 
  end

  defp assert_down(pid) do
    ref = Process.monitor(pid) 
    assert_receive {:DOWN, ^ref, _, _, _}
  end
end