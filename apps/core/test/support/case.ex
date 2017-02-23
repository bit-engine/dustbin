defmodule Core.Case do
  @moduledoc false

  use ExUnit.CaseTemplate

  using do
    quote do
      alias Core.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Core.Case
      import Core.Factory

      use Core.Model
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Core.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Core.Repo, {:shared, self})
    end

    :ok
  end
end
