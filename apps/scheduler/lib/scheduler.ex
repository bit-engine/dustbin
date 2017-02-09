defmodule Scheduler do
  use GenServer
  use Timex

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def pick_locations do
    locations = Core.supported_locations 
    Enum.find(locations, fn loc -> noon?(loc) end)
  end

  defp noon?(location) do
    {_, {hour, _, _}} = Timex.to_erl(Timex.now(location.timezone))
    hour == 12
  end

  def init(state) do
    {:ok, state}
  end
end
