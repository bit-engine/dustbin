defmodule Dustbin.APIWeb.DataCase do
  @moduledoc false

  use ExUnit.CaseTemplate

  using do
    quote do
      alias Dustbin.Data.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Dustbin.API.Factory
      import Dustbin.APIWeb.DataCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Dustbin.Data.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Dustbin.Data.Repo, {:shared, self()})
    end

    :ok
  end
end
