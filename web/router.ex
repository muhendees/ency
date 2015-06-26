defmodule Ency.Router do
  use Ency.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end
	
  pipeline :api do
    plug :accepts, ["json"]
  end
	
  scope "/", Ency do
    pipe_through :browser # Use the default browser stack
		
    get "/", PageController, :index
	end

	scope "/test", Ency do
		pipe_through :browser

		get "/", TestPageController, :index
		get "/users/:page", TestPageController, :show, as: :page
		resources "users", TestPageController
	end
	

	
  # Other scopes may use custom stacks.
  scope "/api", Ency do
		pipe_through :api

		resources "/poets", PoetsController
	end
end
