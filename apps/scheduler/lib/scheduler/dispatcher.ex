defmodule Scheduler.Dispatcher do

  def notify(location = %Core.SupportedLocation{}) do
    collects = Core.upcoming_collects(location)
    if length(collects > 0) do
      initial_message = "[#{location.city}, #{location.country}] - Collects for tomorrow: \n"
      notification_message = compose_notification_message(collects, initial_message)
      ExTwitter.update notification_message
    end
  end

  defp compose_notification_message([], msg), do: msg
  defp compose_notification_message([h | t], msg) do
    compose_notification_message(t, msg <> "#{ - h.collect_type.type } \n") 
  end
end
