defmodule Scheduler do
  use GenServer
  use Timex

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def spawn_notification_tasks do
    GenServer.cast(__MODULE__, :spawn_notification_tasks)
  end
 
  def init(state) do
    {
      Quantum.add_job("@hourly", fn -> spawn_notification_tasks() end),
      state
    }
  end

  def handle_cast(:spawn_notification_tasks, state) do
    # Enum.each(pick_locations(),
    #  fn (location) ->
    #    Task.Supervisor.async_nolink(Scheduler.TasksSupervisor, Messenger, :notify, [location])
    # end
    # )
    {:noreply, state} 
  end

  defp pick_locations do
    Core.supported_locations
    |> Enum.find(fn loc -> noon?(loc) end)
  end

  defp noon?(location = %Core.SupportedLocation{}) do
    erl_datetime = 
      location.timezone
      |> Timex.now
      |> Timex.to_erl

    noon? erl_datetime
  end
  
  defp noon?({_, {12, _, _}}), do: true
  defp noon?(_), do: false
end
