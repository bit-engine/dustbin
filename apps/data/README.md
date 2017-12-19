# Dustbin.Data

This app is in charge of providing access to the repository and also contains the main logic


## Development

After cloning the repo:

- `mix ecto.create`
- `mix ecto.migrate`
- `mix run priv/repo/seeds.exs`

## Production

- Have PostgreSQL installed

### Environment variables

- `DUSTBIN_DB_USERNAME`
- `DUSTBIN_DB_PASSWORD`
- `DUSTBIN_DB_NAME`
- `DUSTBIN_DB_HOSTNAME`
