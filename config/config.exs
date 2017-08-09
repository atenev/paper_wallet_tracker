# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :crypto_watch,
  ecto_repos: [CryptoWatch.Repo]

# Configures the endpoint
config :crypto_watch, CryptoWatchWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ypSacYuIyiSM3nLM9E+90GfcINl2gBF8nMPvMI7rqs8j5OLuZKL3/iYuj04zNQRj",
  render_errors: [view: CryptoWatchWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: CryptoWatch.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
