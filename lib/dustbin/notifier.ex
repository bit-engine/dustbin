defmodule Dustbin.Notifier do
  alias Dustbin.{Locations, Scheduler, Schedules}

  import Crontab.CronExpression

  use GenServer
  use Timex

  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def notify(location_slug, timezone) do
    GenServer.cast(__MODULE__, {:notify, location_slug, timezone})
  end

  # Callbacks
  def init(state) do
    config_jobs() 
    {:ok, state}
  end

  def handle_cast({:notify, location_slug, timezone}, state) do

    with {:ok, occurrences} <- Schedules.find(location_slug, tomorrow(timezone)) do
      Task.Supervisor.start_child(Dustbin.TaskSupervisor, fn ->
      end, restart: :transient)
    end

    {:noreply, state}
  end

  # Helpers
  defp config_jobs do
    Enum.each(Locations.supported(), fn %{name: name, slug: slug, timezone: timezone} ->
      Scheduler.new_job()
      |> Quantum.Job.set_name(:"schedules_#{slug}")
      # |> Quantum.Job.set_schedule(~e[0 16 * * *])
      |> Quantum.Job.set_schedule(~e[* * * * * *]e)
      |> Quantum.Job.set_timezone(timezone)
      |> Quantum.Job.set_task(fn -> Dustbin.Notifier.notify(slug, timezone) end)
      |> Scheduler.add_job()
    end)
  end

  defp tomorrow(timezone) do
    Timex.now(timezone)
    |> Timex.shift(days: 1)
    |> Timex.to_date
    |> Date.to_string
  end
end
