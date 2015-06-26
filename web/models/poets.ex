defmodule Ency.Poets do
	use Ecto.Model


	schema "poets" do
		field :name
		field :surname
		field :birthday
		field :bio

		timestamps

	end
end
