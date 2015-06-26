use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :ency, Ency.Endpoint,
  secret_key_base: "jooGWdKyMuWdFHBx6Mh7lErzWZM3GFJlN+osluoSM9jt46tRbloUBtQtAHkyhXCi"

# Configure your database
config :ency, Ency.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "ency_prod",
  size: 20 # The amount of database connections in the pool
