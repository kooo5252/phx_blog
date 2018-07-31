defmodule PhxBlog.Mixfile do
  use Mix.Project

  def project do
    [app: :phx_blog,
     version: "0.0.1",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {PhxBlog, []},
     applications: [:phoenix, :phoenix_pubsub, :phoenix_html, :cowboy, :logger, :gettext,
                    :phoenix_ecto, :mariaex, :comeonin]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.2.5"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.0"},
      {:mariaex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.6"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.11"},
      {:comeonin, "~> 4.0"},
      {:ex_aws, "~> 2.0", override: true},
      {:ex_aws_kinesis, "~> 2.0"},
      {:ex_aws_s3, "~> 2.0"},
      {:ex_aws_dynamo, "~> 2.0"},
      {:ex_aws_dynamo_streams, "~> 2.0"},
      {:ex_aws_firehose, "~> 2.0"},
      {:ex_aws_lambda, "~> 2.0"},
      {:ex_aws_sns, "~> 2.0"},
      {:ex_aws_sqs, "~> 2.0"},
      {:ex_aws_ses, "~> 2.0"},
      {:ex_aws_route53, "~> 2.0"},
      {:ex_aws_cloudwatch, "~> 2.0"},
      {:hackney, "~> 1.9"},
      {:sweet_xml, "~> 0.6"},
      {:poison, "~> 3.0", override: true},
      {:httpoison, ">= 0.0.0"},
#      {:bcrypt_elixir, "~> 1.0"},
      {:cowboy, "~> 1.0"}
   ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
