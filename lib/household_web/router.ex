defmodule HouseholdWeb.Router do
  use HouseholdWeb, :router

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

  scope "/", HouseholdWeb do
    pipe_through :browser
    get "/devices", ServiceController, :devices
    get "/new-device", ServiceController, :new_device
    post "/add-device", ServiceController, :add_device
    delete "/delete-device/:id", ServiceController, :delete_device
    get "/edit-device/:id", ServiceController, :edit_device
    put "/update-device", ServiceController, :update_device
  end

  # Other scopes may use custom stacks.
  # scope "/api", HouseholdWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: HouseholdWeb.Telemetry
    end
  end
end
