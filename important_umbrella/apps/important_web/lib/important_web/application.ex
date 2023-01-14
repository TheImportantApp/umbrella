defmodule ImportantWeb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ImportantWeb.Telemetry,
      # Start the Endpoint (http/https)
      ImportantWeb.Endpoint
      # Start a worker by calling: ImportantWeb.Worker.start_link(arg)
      # {ImportantWeb.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ImportantWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ImportantWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
