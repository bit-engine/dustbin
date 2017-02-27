defmodule AI do
  @moduledoc """
    This module is in charge of interacting with wit.ai api via elixir-wit and at the same
    time it will maintain the data for each user session needed to group the conversations per
    user.
  """
  
  @wit_max_steps 10
  @actions_module AI.Actions

  use GenServer

  # Client
  
  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def process(raw_text, sender) do
    %{session_id: session_id, context: context} = create_session sender
    GenServer.call(__MODULE__, {:process, raw_text, session_id, context})
  end

  def create_session(sender) do
    GenServer.call(__MODULE__, {:create_session, sender})
  end


  # Server 
  
  def init(state) do
    {:ok, state}
  end

  def handle_call({:process, raw_text, session_id, context}, _from, state) do
    Task.Supervisor.async_nolink(AI.TaskSupervisor, fn -> run_actions(raw_text, session_id, context) end)  
    {:noreply, state}
  end

  # TODO: Refactor out handle_call response by getting out the state from case
  #       new_state = 
  #         case Map.get(...)
  def handle_call({:create_session, sender}, _from, state) do
    case Map.get(state, sender) do
      result when is_map(result) -> {:reply, result, state}
      nil ->
        session = %{session_id: "#{sender}-#{unix_timestamp()}", context: %{sender: sender}}
        {:reply, session, Map.put(state, sender, session)}
    end
  end

  # TODO: Here context check sould be done:
  #       if context has a done key with true value, the conversation
  #       is finished an a new one must be created once the user sends a new message.
  #       Note: _finishing_ a conversation is relative to the bot's business logic
  #       If context doesn't contain such key/value, the current context should be updated with the new one
  def handle_info({_, {:ok, context}}, state) do
    {:noreply, state}
  end

  # Private/Helper functions
  
  defp run_actions(raw_text, session_id, context) do
    token = Application.get_env(:ai, :wit_access_token)
    Wit.run_actions(token, session_id,  @actions_module, raw_text, context, @wit_max_steps)
  end
  
  defp unix_timestamp do
    DateTime.utc_now()
    |> DateTime.to_unix()
  end
end
