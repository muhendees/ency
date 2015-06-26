defmodule Ency.TestPage do
	use Ecto.Model



	schema "users" do
		field :name, :string
		field :bio, :string
	end
	
	@required_fields ~w(name)

end
