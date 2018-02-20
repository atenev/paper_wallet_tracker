defmodule CryptoWatch.AddressManagerTest do
  use CryptoWatch.DataCase

  alias CryptoWatch.AddressManager

  describe "public_addresses" do
    alias CryptoWatch.AddressManager.PublicAddress

    @valid_attrs %{address: "some address", name: "some name"}
    @update_attrs %{address: "some updated address", name: "some updated name"}
    @invalid_attrs %{address: nil, name: nil}

    def public_address_fixture(attrs \\ %{}) do
      {:ok, public_address} =
        attrs
        |> Enum.into(@valid_attrs)
        |> AddressManager.create_public_address()

      public_address
    end

    test "list_public_addresses/0 returns all public_addresses" do
      public_address = public_address_fixture()
      assert AddressManager.list_public_addresses() == [public_address]
    end

    test "get_public_address!/1 returns the public_address with given id" do
      public_address = public_address_fixture()
      assert AddressManager.get_public_address!(public_address.id) == public_address
    end

    test "create_public_address/1 with valid data creates a public_address" do
      assert {:ok, %PublicAddress{} = public_address} =
               AddressManager.create_public_address(@valid_attrs)

      assert public_address.address == "some address"
      assert public_address.name == "some name"
    end

    test "create_public_address/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AddressManager.create_public_address(@invalid_attrs)
    end

    test "update_public_address/2 with valid data updates the public_address" do
      public_address = public_address_fixture()

      assert {:ok, public_address} =
               AddressManager.update_public_address(public_address, @update_attrs)

      assert %PublicAddress{} = public_address
      assert public_address.address == "some updated address"
      assert public_address.name == "some updated name"
    end

    test "update_public_address/2 with invalid data returns error changeset" do
      public_address = public_address_fixture()

      assert {:error, %Ecto.Changeset{}} =
               AddressManager.update_public_address(public_address, @invalid_attrs)

      assert public_address == AddressManager.get_public_address!(public_address.id)
    end

    test "delete_public_address/1 deletes the public_address" do
      public_address = public_address_fixture()
      assert {:ok, %PublicAddress{}} = AddressManager.delete_public_address(public_address)

      assert_raise Ecto.NoResultsError, fn ->
        AddressManager.get_public_address!(public_address.id)
      end
    end

    test "change_public_address/1 returns a public_address changeset" do
      public_address = public_address_fixture()
      assert %Ecto.Changeset{} = AddressManager.change_public_address(public_address)
    end
  end
end
