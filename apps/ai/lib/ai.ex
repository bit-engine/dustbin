defmodule AI do
  @moduledoc """
  This module is in charge of interacting with wit.ai api via elixir-wit and at the same
  time it will maintain the data for each user session needed to group the conversations per
  user.
  """

  @wit_max_steps 10
  @actions_module AI.Actions
  @wit Application.get_env(:ai, :wit_api)

  use GenServer

  # Client

  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def process(raw_text, sender) do
    {session_id, %{context: context}} = create_session sender
    GenServer.cast(__MODULE__, {:process, raw_text, session_id, context})
  end

  def create_session(sender) do
    GenServer.call(__MODULE__, {:create_session, sender})
  end


  # Server 

  def init(state) do
    {:ok, state}
  end

  def handle_cast({:process, raw_text, session_id, context}, state) do
    task = Task.Supervisor.async_nolink(AI.TaskSupervisor, fn -> run_actions(raw_text, session_id, context) end)  
    new_state = add_task_to_session(state, session_id, task)
    {:noreply, new_state}
  end

  def handle_call({:create_session, sender}, _from, state) do
    case Enum.find(state, fn {_, v} -> v.fbid == sender end) do
      {_, _} = result -> {:reply, result, state}
      nil ->
        session_id = "#{sender}-#{unix_timestamp()}"
        session_value = %{fbid: sender, context: %{}, tasks: []}
        {:reply, {session_id, session_value}, Map.put(state, session_id, session_value)}
    end
  end

  def handle_info({ref, {:ok, context}}, state) do
    new_state = 
      case Enum.find(state, &session_contains_task?(&1, ref)) do
        {session_id, _} ->
          if Map.has_key?(context, :done) do
            remove_session(state, session_id)
          else
            update_session_context(state, session_id, context)
            |> remove_task_from_session(session_id, ref)
          end
        nil -> state
      end
    {:noreply, new_state}
  end

  def handle_info({:DOWN, _, _, _, _}, state), do: {:noreply, state}

  # Private/Helper functions

  defp update_session_context(state, session_id, new_context) do
    session_value = Map.get(state, session_id)
    state
    |> Map.put(session_id, Map.put(session_value, :context, new_context))
  end

  defp remove_task_from_session(state, session_id, ref) do
    session_value = Map.get(state, session_id)
    remaining_tasks = session_value.tasks -- [ref]
    new_session_value = Map.put(session_value, :tasks, remaining_tasks)
    state
    |> Map.put(session_id, new_session_value)
  end

  defp remove_session(state, session_id) do
    {_, result} = Map.pop(state, session_id)
    result
  end

  defp session_contains_task?({_, session_value}, ref) do
    ref in session_value.tasks 
  end

  defp add_task_to_session(state, session_id, %Task{ref: ref}) do
    if session_value = state[session_id] do
      new_session_value = Map.put(session_value, :tasks, session_value.tasks ++ [ref])
      Map.put(state, session_id, new_session_value)
    else
      state
    end
  end

  defp run_actions(raw_text, session_id, context) do
    token = Application.get_env(:ai, :wit_access_token)
    @wit.run_actions(token, session_id,  @actions_module, raw_text, context, @wit_max_steps)
  end

  defp unix_timestamp do
    DateTime.utc_now()
    |> DateTime.to_unix()
  end
end
