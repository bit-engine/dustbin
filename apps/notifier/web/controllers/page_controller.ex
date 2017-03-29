defmodule Notifier.PageController do
  use Notifier.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
