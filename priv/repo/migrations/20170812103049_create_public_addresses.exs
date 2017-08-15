defmodule CryptoWatch.Repo.Migrations.CreatePublicAddresses do
  use Ecto.Migration

  def change do
    create table(:public_addresses) do
      add :address, :string
      add :name, :string

      timestamps()
    end

  end
end
