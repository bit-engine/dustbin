defmodule Scheduler.Supervisor do
  @moduledoc false

  use Supervisor

  def start_link(state) do
    Supervisor.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    children = [
      supervisor(Task.Supervisor, [[name: Scheduler.TasksSupervisor]]),
      worker(Scheduler, [state], restart: :temporary)
    ]
    supervise children, strategy: :one_for_one
  end
end
