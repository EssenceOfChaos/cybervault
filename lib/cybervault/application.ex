defmodule Cybervault.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      CybervaultWeb.Telemetry,
      # Start the Ecto repository
      Cybervault.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Cybervault.PubSub},
      # Start Finch
      {Finch, name: Cybervault.Finch},
      # Start the Endpoint (http/https)
      CybervaultWeb.Endpoint,
      Cybervault.Healthcheck.Supervisor
      # Start a worker by calling: Cybervault.Worker.start_link(arg)
      # {Cybervault.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Cybervault.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CybervaultWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
