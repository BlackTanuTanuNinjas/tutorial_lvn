defmodule TutorialLvn.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TutorialLvnWeb.Telemetry,
      TutorialLvn.Repo,
      {DNSCluster, query: Application.get_env(:tutorial_lvn, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TutorialLvn.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: TutorialLvn.Finch},
      # Start a worker by calling: TutorialLvn.Worker.start_link(arg)
      # {TutorialLvn.Worker, arg},
      # Start to serve requests, typically the last entry
      TutorialLvnWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TutorialLvn.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TutorialLvnWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
