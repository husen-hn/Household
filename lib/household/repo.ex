defmodule Household.Repo do
  use Ecto.Repo,
    otp_app: :household,
    adapter: Ecto.Adapters.Postgres
end
