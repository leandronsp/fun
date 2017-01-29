defmodule HelloPhoenix.PageController do
  use HelloPhoenix.Web, :controller

  def index(conn, _params) do
    #redirect conn, to: redirect_test_path(conn, :redirect_test)

    conn
    |> put_flash(:info, "Welcome to Phoenix, from flash info!")
    |> put_flash(:error, "Let's pretend we have an error")
    |> render("index.html")

    #render conn, "index.html"
  end

  def redirect_test(conn, _params) do
    text conn, "Redirect!"
  end
end
