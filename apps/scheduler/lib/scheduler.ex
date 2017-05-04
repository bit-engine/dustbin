defmodule Scheduler do
  @moduledoc """
  This module serves as a notification task dispatcher.
  A Quantum job will execute `spawn_notification_tasks` every certain amount of time (normally every hour).
  """

  use GenServer
  use Timex

  alias Scheduler.Dispatcher

  require Logger

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
    Logger.info "[Scheduler] Running job @ #{timestamp()}"
    Enum.each(pick_locations(),
      fn (location) ->
        Task.Supervisor.async_nolink(Scheduler.TaskSupervisor, Dispatcher, :notify, [location])
      end
    )
    {:noreply, state} 
  end

  # Returns all supported locations in which it's noon, using the location's timezone
  defp pick_locations do
    Core.supported_locations
    |> Enum.take_while(&noon?/1)
  end

  # For a given location, it verifies if it's noon in the location's timezone
  # relative to the moment of execution of the function 
  defp noon?(location = %Core.SupportedLocation{}) do
    erl_datetime = 
      location.timezone
      |> Timex.now
      |> Timex.to_erl

    noon? erl_datetime
  end
  
  defp timestamp do
    Timex.now("America/Toronto")
    |> Timex.format!("%FT%T%:z", :strftime)
  end
  defp noon?({_, {12, _, _}}), do: true
  defp noon?(_), do: false
end
