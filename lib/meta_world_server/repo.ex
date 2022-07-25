defmodule MetaWorldServer.Repo do
  use Ecto.Repo,
    otp_app: :meta_world_server,
    adapter: Ecto.Adapters.Postgres
end
