defmodule Ency.PageController do
  use Ency.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end
