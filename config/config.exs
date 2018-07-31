# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :phx_blog,
  ecto_repos: [PhxBlog.Repo]

# Configures the endpoint
config :phx_blog, PhxBlog.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "DfjQqnifVwPDCEKTxrGlPdUoG5/fC5SXPw1Gcm/kYTLqqvqToagvsd5i0I6GkhJv",
  render_errors: [view: PhxBlog.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhxBlog.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ex_aws,
  access_key_id: "foo",
  secret_access_key: "bar"

config :ex_aws, :kinesis,
  scheme: "http://",
  host: "localhost",
  port: 4568,
  region: "us-east-1"

config :ex_aws, :dynamodb,
  scheme: "http://",
  host: "localhost",
  port: 4569,
  region: "us-east-1"

config :ex_aws, :dynamodb_streams,
  scheme: "http://",
  host: "localhost",
  port: 4570,
  region: "us-east-1"

config :ex_aws, :s3,
  scheme: "http://",
  host: "localhost",
  port: 4572,
  region: "us-east-1"

config :ex_aws, :firehose,
  scheme: "http://",
  host: "localhost",
  port: 4573,
  region: "us-east-1"

config :ex_aws, :lambda,
  scheme: "http://",
  host: "localhost",
  port: 4574,
  region: "us-east-1"

config :ex_aws, :sns,
  scheme: "http://",
  host: "localhost",
  port: 4575,
  region: "us-east-1"

config :ex_aws, :sqs,
  scheme: "http://",
  host: "localhost",
  port: 4576,
  region: "us-east-1"

config :ex_aws, :sqs,
  scheme: "http://",
  host: "localhost",
  port: 4576,
  region: "us-east-1"

config :ex_aws, :ses,
  scheme: "http://",
  host: "localhost",
  port: 4579,
  region: "us-east-1"

config :ex_aws, :route53,
  scheme: "http://",
  host: "localhost",
  port: 4580,
  region: "us-east-1"

config :ex_aws, :cloudwatch,
  scheme: "http://",
  host: "localhost",
  port: 4581,
  region: "us-east-1"
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
