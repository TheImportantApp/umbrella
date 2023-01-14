defmodule Important.Repo do
  use Ecto.Repo,
    otp_app: :important,
    adapter: Ecto.Adapters.Postgres
end
