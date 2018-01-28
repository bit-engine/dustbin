defmodule Dustbin.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Dustbin.Scheduler, []),
      worker(Dustbin.Notifier, [])
    ]

    opts = [strategy: :one_for_one, name: Dustbin.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
