defmodule Dustbin.PageController do
  use Dustbin.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
