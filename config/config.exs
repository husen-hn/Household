# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :household,
  ecto_repos: [Household.Repo]

# Configures the endpoint
config :household, HouseholdWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "MPD3WTG5FDK7wCSc4NQVgjq3u8r3w5nB/IFfq4bgwebQGhhMqnbvHfuCaTdAuf8s",
  render_errors: [view: HouseholdWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Household.PubSub,
  live_view: [signing_salt: "YilybB6R"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
