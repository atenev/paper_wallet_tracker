defmodule CryptoWatchWeb.PublicAddressController do
  use CryptoWatchWeb, :controller

  alias CryptoWatch.BlockchainInfo
  alias CryptoWatch.AddressManager
  alias CryptoWatch.AddressManager.PublicAddress

  # @btc_price BlockchainInfo.getBTCPrice("USD")

  def index(conn, _params) do
    {public_addresses, total_price} =
      AddressManager.list_public_addresses()
      |> query_balance
      |> query_price
      |> total_price

    render(conn, "index.html", public_addresses: public_addresses, total_price: total_price)
  end

  def new(conn, _params) do
    changeset = AddressManager.change_public_address(%PublicAddress{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"public_address" => public_address_params}) do
    case AddressManager.create_public_address(public_address_params) do
      {:ok, public_address} ->
        conn
        |> put_flash(:info, "Public address created successfully.")
        |> redirect(to: public_address_path(conn, :show, public_address))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    public_address = AddressManager.get_public_address!(id)
    render(conn, "show.html", public_address: public_address)
  end

  def edit(conn, %{"id" => id}) do
    public_address = AddressManager.get_public_address!(id)
    changeset = AddressManager.change_public_address(public_address)
    render(conn, "edit.html", public_address: public_address, changeset: changeset)
  end

  def update(conn, %{"id" => id, "public_address" => public_address_params}) do
    public_address = AddressManager.get_public_address!(id)

    case AddressManager.update_public_address(public_address, public_address_params) do
      {:ok, public_address} ->
        conn
        |> put_flash(:info, "Public address updated successfully.")
        |> redirect(to: public_address_path(conn, :show, public_address))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", public_address: public_address, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    public_address = AddressManager.get_public_address!(id)
    {:ok, _public_address} = AddressManager.delete_public_address(public_address)

    conn
    |> put_flash(:info, "Public address deleted successfully.")
    |> redirect(to: public_address_path(conn, :index))
  end

  # Helper functions

  defp query_balance(public_address_list) do
    Enum.map(public_address_list, &update_balance(&1))
  end

  defp update_balance(
         %CryptoWatch.AddressManager.PublicAddress{address: address} = public_address_struct
       ) do
    public_address_struct
    |> Map.update!(:balance, fn _ -> BlockchainInfo.getBalance(address) end)
  end

  defp query_price(public_address_list) do
    Enum.map(public_address_list, &update_price(&1, BlockchainInfo.getBTCPrice("USD")))
  end

  defp update_price(
         %CryptoWatch.AddressManager.PublicAddress{price: price, balance: balance} =
           public_address_struct,
         last_price
       ) do
    public_address_struct
    |> Map.update!(:price, fn _ -> last_price * balance end)
  end

  defp total_price(public_address_list) do
    {public_address_list,
     Enum.reduce(public_address_list, acc = 0, fn %CryptoWatch.AddressManager.PublicAddress{
                                                    price: price
                                                  },
                                                  acc ->
       acc + price
     end)}
  end
end
