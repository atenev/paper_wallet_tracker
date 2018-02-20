defmodule CryptoWatchWeb.RegistrationController do
  use CryptoWatchWeb, :controller
  alias CryptoWatch.Acounting

  def new(conn, _params) do
    changeset = Acounting.build_user()
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => registration_data}) do
    case Acounting.create_user(registration_data) do
      {:ok, customer} ->
        conn
        |> put_flash(:info, "Registration successful")
        |> redirect(to: page_path(conn, :index))

      {:error, changeset} ->
        conn
        |> render(:new, changeset: changeset)
    end
  end
end
