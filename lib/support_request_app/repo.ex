defmodule SupportRequestApp.Repo do
  use Ecto.Repo,
    otp_app: :support_request_app,
    adapter: Ecto.Adapters.Postgres
end
