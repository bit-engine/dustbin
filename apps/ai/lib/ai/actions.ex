defmodule AI.Actions do
  @moduledoc """
  This module defines wit custom actions
  """

  use Wit.Actions

  def say(session, context, message) do
    # Send Message to user in FB
  end

  def merge(session, context, message) do
    context
  end

  def error(session, context, error) do
  end

  defaction verify_subscription(session, context, message) do
      
  end
end
