defmodule Ency.PoetsView do
	use Ency.Web, :view


	def render("index.json", %{poets: poets}) do
		poets
	end
end
