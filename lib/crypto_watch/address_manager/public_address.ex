defmodule CryptoWatch.AddressManager.PublicAddress do
  use Ecto.Schema
  import Ecto.Changeset
  alias CryptoWatch.AddressManager.PublicAddress


  schema "public_addresses" do
    field :address, :string
    field :name, :string
    field :balance, :integer, virtual: true
    field :price, :integer, virtual: true

    timestamps()
  end

  @doc false
  def changeset(%PublicAddress{} = public_address, attrs) do
    public_address
    |> cast(attrs, [:address, :name])
    |> validate_required([:address, :name])
  end
end
