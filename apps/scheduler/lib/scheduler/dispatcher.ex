defmodule Scheduler.Dispatcher do

  def notify(location = %{:timezone => timezone, :city => city, }) do
    collects = Dustbin.Data.upcoming_collects(location.slug)
    if length(collects) > 0 do
      initial_message = "[#{city}] - Collects for #{tomorrow(timezone)}: \n"
      notification_message = compose_notification_message(collects, initial_message)
      ExTwitter.update notification_message
    end
  end

  defp compose_notification_message([], msg), do: msg
  defp compose_notification_message([h | t], msg) do
    compose_notification_message(t, msg <> "- #{h.name } \n") 
  end

  defp tomorrow(timezone) do
    Timex.now(timezone)
    |> Timex.to_date
    |> Timex.shift(days: 1)
  end
end
