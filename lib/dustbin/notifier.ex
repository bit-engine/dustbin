defmodule Dustbin.Notifier do
  alias Dustbin.{Locations, Scheduler}

  import Crontab.CronExpression

  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end
  
  def init(state) do
    config_jobs() 
    {:ok, state}
  end

  # Helpers
  defp config_jobs do
    Enum.each(Locations.supported(), fn %{name: name, slug: slug, timezone: timezone} ->
      Scheduler.new_job()
      |> Quantum.Job.set_name(:"schedules_#{slug}")
      |> Quantum.Job.set_schedule(~e[0 16 * * *])
      |> Quantum.Job.set_timezone(timezone)
      |> Quantum.Job.set_task(fn -> IO.puts "Jobbing!" end)
      |> Scheduler.add_job()
    end)
  end
end
