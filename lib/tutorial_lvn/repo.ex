defmodule TutorialLvn.Repo do
  use Ecto.Repo,
    otp_app: :tutorial_lvn,
    adapter: Ecto.Adapters.Postgres
end
