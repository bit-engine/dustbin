defmodule Receiver.PageController do
  use Receiver.Web, :controller

  def index(conn, _params) do
    render conn, "index.html", name: "Saúl"
  end
end
