defmodule Cumbia.Router do
  use Cumbia.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Cumbia do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    scope "/dashboard" do
      get "/", DashboardController, :index
      get "/new", DashboardController, :new
      get "/:project_id", DashboardController, :show
      post "/:project_id", AudioController, :generate

      get "/:project_id/audio/:audio_id", DashboardController, :show
    end
  end

  # Other scopes may use custom stacks.
  scope "/api", Cumbia do
    pipe_through :api

    post "/:entity_name", MasterController, :create
  end
end
