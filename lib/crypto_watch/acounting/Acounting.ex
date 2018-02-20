defmodule CryptoWatch.Acounting do
  alias CryptoWatch.Acounting.User
  alias CryptoWatch.Repo

  def build_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
  end

  def create_user(attrs) do
    attrs
    |> build_user
    |> Repo.insert()
  end

  def get_user_by_username(username), do: Repo.get_by(User, username: username)

  def get_user_by_credentials(%{"username" => username, "password" => pass}) do
    user = get_user_by_username(username)

    cond do
      user && Comeonin.Bcrypt.checkpw(pass, user.password_hash) -> user
      true -> :error
    end
  end

  def get_user(id), do: Repo.get(User, id)
end
