ExUnit.start()

# AI declares --no-start at the beginning so we need to start applications needed in the tests manually
Application.ensure_all_started(:core)