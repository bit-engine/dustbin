defmodule Dustbin.Notifier do
  alias Dustbin.{Locations, Scheduler, Schedules}

  import Crontab.CronExpression

  use GenServer
  use Timex

  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def notify(name, location_slug, timezone) do
    GenServer.cast(__MODULE__, {:notify, name, location_slug, timezone})
  end

  # Callbacks
  def init(state) do
    config_jobs() 
    {:ok, state}
  end

  def handle_cast({:notify, name, location_slug, timezone}, state) do
    
    date = tomorrow(timezone)

    with {:ok, occurrences} <- Schedules.find(location_slug, Date.to_string(date)) do
      Task.Supervisor.start_child(Dustbin.TaskSupervisor, fn ->
        format_notification(name, occurrences, date)
        |> ExTwitter.update
      end, restart: :transient)
    end

    {:noreply, state}
  end

  # Helpers
  defp config_jobs do
    Enum.each(Locations.supported(), fn %{name: name, slug: slug, timezone: timezone} ->
      Scheduler.new_job()
      |> Quantum.Job.set_schedule(~e[0 16 * * *])
      |> Quantum.Job.set_timezone(timezone)
      |> Quantum.Job.set_task(fn -> Dustbin.Notifier.notify(name, slug, timezone) end)
      |> Scheduler.add_job()
    end)
  end

  defp format_notification(name, occurrences, date) do 
    occurrences_msg =
      Enum.reduce(occurrences, "", fn
        %{"name" => name}, "" -> name
        %{"name" => name}, acc ->
          """
          #{acc}
          #{name}
          """
      end)

    date_msg =
      date
      |> Timex.format!("{WDshort} {Mshort} {D}, {YYYY}")

    """
    #{name}
    #{date_msg}:
    #{occurrences_msg}
    """
  end

  defp tomorrow(timezone) do
    Timex.now(timezone)
    |> Timex.shift(days: 1)
    |> Timex.to_date
  end
end
