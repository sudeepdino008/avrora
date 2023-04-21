use Mix.Config

config :avrora,
  schemas_path: Path.expand("./myschemas"),
  registry_url: nil,
  registry_auth: nil,
  registry_user_agent: nil,
  registry_schemas_autoreg: false,
  convert_null_values: true,
  names_cache_ttl: :infinity

config :logger, :console, format: "$time $metadata[$level] $levelpad$message\n"
