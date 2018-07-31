use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or you later on).
config :phx_blog, PhxBlog.Endpoint,
  secret_key_base: "kiRCdjds+oyi6snhX7JVJ49lptn9/FyIw+xBZUK4qgQWGu8TiA602H7aig2mjFFW"

# Configure your database
config :phx_blog, PhxBlog.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "root",
  password: "root",
  database: "phx_blog_prod",
  pool_size: 20
