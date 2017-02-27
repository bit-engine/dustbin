defmodule AI.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(Task.Supervisor, [[name: AI.TaskSupervisor]]),
      worker(AI, [])
    ]

    opts = [strategy: :one_for_one, name: AI.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
