defmodule Api.Repo do
  @moduledoc false
  use Ecto.Repo,
    otp_app: :api,
    adapter: Ecto.Adapters.Postgres
end
