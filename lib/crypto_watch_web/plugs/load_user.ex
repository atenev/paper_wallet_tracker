defmodule CryptoWatchWeb.Plugs.LoadUser do
  import Plug.Conn
  alias CryptoWatch.Acounting

  def init(_opts), do: nil

  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    user = user_id && Acounting.get_user(user_id)
    assign(conn, :current_user, user)
  end
end
