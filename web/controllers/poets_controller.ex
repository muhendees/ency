defmodule Ency.PoetsController do
	use Ency.Web, :controller
	alias Ency.Repo
	alias Ency.Poets

	plug :action


	def index(conn, _params) do
		poets = Repo.all(Poets)
		render conn, poets: poets
	end
end
