defmodule CryptoWatchWeb.PublicAddressControllerTest do
  use CryptoWatchWeb.ConnCase

  alias CryptoWatch.AddressManager

  @create_attrs %{address: "some address", name: "some name"}
  @update_attrs %{address: "some updated address", name: "some updated name"}
  @invalid_attrs %{address: nil, name: nil}

  def fixture(:public_address) do
    {:ok, public_address} = AddressManager.create_public_address(@create_attrs)
    public_address
  end

  describe "index" do
    test "lists all public_addresses", %{conn: conn} do
      conn = get conn, public_address_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Public addresses"
    end
  end

  describe "new public_address" do
    test "renders form", %{conn: conn} do
      conn = get conn, public_address_path(conn, :new)
      assert html_response(conn, 200) =~ "New Public address"
    end
  end

  describe "create public_address" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, public_address_path(conn, :create), public_address: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == public_address_path(conn, :show, id)

      conn = get conn, public_address_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Public address"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, public_address_path(conn, :create), public_address: @invalid_attrs
      assert html_response(conn, 200) =~ "New Public address"
    end
  end

  describe "edit public_address" do
    setup [:create_public_address]

    test "renders form for editing chosen public_address", %{conn: conn, public_address: public_address} do
      conn = get conn, public_address_path(conn, :edit, public_address)
      assert html_response(conn, 200) =~ "Edit Public address"
    end
  end

  describe "update public_address" do
    setup [:create_public_address]

    test "redirects when data is valid", %{conn: conn, public_address: public_address} do
      conn = put conn, public_address_path(conn, :update, public_address), public_address: @update_attrs
      assert redirected_to(conn) == public_address_path(conn, :show, public_address)

      conn = get conn, public_address_path(conn, :show, public_address)
      assert html_response(conn, 200) =~ "some updated address"
    end

    test "renders errors when data is invalid", %{conn: conn, public_address: public_address} do
      conn = put conn, public_address_path(conn, :update, public_address), public_address: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Public address"
    end
  end

  describe "delete public_address" do
    setup [:create_public_address]

    test "deletes chosen public_address", %{conn: conn, public_address: public_address} do
      conn = delete conn, public_address_path(conn, :delete, public_address)
      assert redirected_to(conn) == public_address_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, public_address_path(conn, :show, public_address)
      end
    end
  end

  defp create_public_address(_) do
    public_address = fixture(:public_address)
    {:ok, public_address: public_address}
  end
end
