defmodule Important.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Important.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Important.PubSub},
      # Start Finch
      {Finch, name: Important.Finch}
      # Start a worker by calling: Important.Worker.start_link(arg)
      # {Important.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Important.Supervisor)
  end
end
