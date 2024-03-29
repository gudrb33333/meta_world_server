defmodule MetaWorldServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      MetaWorldServer.Repo,
      # Start the Telemetry supervisor
      MetaWorldServerWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub,
       [
         name: MetaWorldServer.PubSub,
         adapter: Phoenix.PubSub.Redis,
         host: System.get_env("REDIS_HOST"),
         port: 6379,
         node_name: System.get_env("PHOENIX_NODE")
       ]},
      # String the Presence system
      MetaWorldServerWeb.Presence,
      # Start the Endpoint (http/https)
      MetaWorldServerWeb.Endpoint
      # Start a worker by calling: MetaWorldServer.Worker.start_link(arg)
      # {MetaWorldServer.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MetaWorldServer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MetaWorldServerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
