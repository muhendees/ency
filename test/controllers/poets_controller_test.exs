defmodule Ency.PoetsControllerTest do
	use ExUnit.Case, async: false
	use Plug.Test
	alias Ency.Poets
	alias Ency.Repo



	test "/index returns a list of poets" do
		poets_as_json =
			%Poets{name: "Javad", surname: "Mustafayev", birthday: "21-Feb-1988", bio: "asdasdaoijsodifjosidjfosidjfosijdfoisjfd"}
		|>Repo.insert!
		|>List.wrap
		|>Poison.encode!
		
		response = conn(:get, "/api/poets") |> send_request
		
		assert response.status == 200
		assert response.resp_body == poets_as_json
	end
	
	defp send_request(conn) do
		conn
		|> put_private(:plug_skip_csrf_protection, true)
		|> Ency.Endpoint.call([])
	end
end
