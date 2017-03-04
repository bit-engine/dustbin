defmodule AI.WitSandbox do
  @moduledoc """
  This module is a mock for Wit HTTP client to use in test env.
  """

  def run_actions(token, session_id, module, text, context, max_steps) do
    new_context = 
      if Map.has_key?(context, :end) do
        %{done: true}
      else
        %{random_key: :random_value}
      end
    {:ok, new_context}
  end
end
