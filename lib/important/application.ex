defmodule Important.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ImportantWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:important, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Important.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Important.Finch},
      # Start task store registry
      {Registry, keys: :unique, name: Important.TaskStoreRegistry},
      # Start to serve requests, typically the last entry
      ImportantWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Important.Supervisor]
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
