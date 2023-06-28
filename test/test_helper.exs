Bureaucrat.start(
  default_path: "priv/static/doc/README.md",
  json_library: Jason
)

{:ok, _} = Application.ensure_all_started(:ex_machina)
ExUnit.start(formatters: [ExUnit.CLIFormatter, Bureaucrat.Formatter])
Ecto.Adapters.SQL.Sandbox.mode(Api.Repo, :manual)
Faker.start()
