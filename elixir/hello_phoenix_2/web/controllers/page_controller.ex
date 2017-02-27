defmodule HelloPhoenix2.PageController do
  use HelloPhoenix2.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
