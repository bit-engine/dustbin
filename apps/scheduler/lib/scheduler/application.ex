defmodule Scheduler.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    Scheduler.Supervisor.start_link([])
  end
end
