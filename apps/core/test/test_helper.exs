ExUnit.start()

# Set the pool mode to manual for explicit connection checkouts
Ecto.Adapters.SQL.Sandbox.mode(Core.Repo, :manual)
