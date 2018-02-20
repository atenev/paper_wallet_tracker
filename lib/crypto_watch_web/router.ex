defmodule CryptoWatchWeb.Router do
  use CryptoWatchWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(CryptoWatchWeb.Plugs.LoadUser)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", CryptoWatchWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    resources("/public_addresses", PublicAddressController)
    get("/register", RegistrationController, :new)
    post("/register", RegistrationController, :create)
    get("/login", SessionController, :new)
    post("/login", SessionController, :create)
    get("/logout", SessionController, :delete)
  end

  # Other scopes may use custom stacks.
  # scope "/api", CryptoWatchWeb do
  #   pipe_through :api
  # end
end
