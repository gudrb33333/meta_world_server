defmodule MetaWorldServerWeb.PageController do
  use MetaWorldServerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
