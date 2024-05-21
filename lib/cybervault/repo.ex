defmodule Cybervault.Repo do
  use Ecto.Repo,
    otp_app: :cybervault,
    adapter: Ecto.Adapters.Postgres
end
