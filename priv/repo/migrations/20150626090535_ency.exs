defmodule Ency.Repo.Migrations.Ency do
  use Ecto.Migration

  def change do
		create table(:poets) do
			add :name
			add :surname
			add :birthday
			add :bio

			timestamps
		end

		create table(:users) do
			add :name
			add :bio

			timestamps

		end
	end
end
