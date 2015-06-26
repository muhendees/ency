defmodule Ency.TestPageController do
	use Ency.Web, :controller
  alias Ency.Repo
	alias Ency.TestPage

	import Ency.Router.Helpers
	
	plug :action
	
	def index(conn, _params) do
		render conn, "index.html", users: Repo.all(TestPage)
	end

	
	def show(conn, %{"id" => id}) do
		case Repo.get(TestPage, id) do
			user when is_map(user) ->
				render conn, "show", user: user
			_ ->
				redirect conn, Router.users_path(page: "unauthorized")
		end
	end
	
	def new(conn, _params) do
		render conn, "new"
	end
	
	def create(conn, %{"user" => %{"name" => name, "bio" => bio}}) do
		user = %TestPage{name: name, bio: bio}
		case user do
										
			[] ->

				user = Repo.insert(user)
				render conn, "show", user: user

			errors ->
				render conn, "new", user: user, errors: errors
		end
		
	end
	
end

