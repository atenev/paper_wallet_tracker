defmodule CryptoWatch.AddressManager do
  @moduledoc """
  The AddressManager context.
  """

  import Ecto.Query, warn: false
  alias CryptoWatch.Repo

  alias CryptoWatch.AddressManager.PublicAddress

  @doc """
  Returns the list of public_addresses.

  ## Examples

      iex> list_public_addresses()
      [%PublicAddress{}, ...]

  """
  def list_public_addresses do
    Repo.all(PublicAddress)
  end

  @doc """
  Gets a single public_address.

  Raises `Ecto.NoResultsError` if the Public address does not exist.

  ## Examples

      iex> get_public_address!(123)
      %PublicAddress{}

      iex> get_public_address!(456)
      ** (Ecto.NoResultsError)

  """
  def get_public_address!(id), do: Repo.get!(PublicAddress, id)

  @doc """
  Creates a public_address.

  ## Examples

      iex> create_public_address(%{field: value})
      {:ok, %PublicAddress{}}

      iex> create_public_address(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_public_address(attrs \\ %{}) do
    %PublicAddress{}
    |> PublicAddress.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a public_address.

  ## Examples

      iex> update_public_address(public_address, %{field: new_value})
      {:ok, %PublicAddress{}}

      iex> update_public_address(public_address, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_public_address(%PublicAddress{} = public_address, attrs) do
    public_address
    |> PublicAddress.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a PublicAddress.

  ## Examples

      iex> delete_public_address(public_address)
      {:ok, %PublicAddress{}}

      iex> delete_public_address(public_address)
      {:error, %Ecto.Changeset{}}

  """
  def delete_public_address(%PublicAddress{} = public_address) do
    Repo.delete(public_address)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking public_address changes.

  ## Examples

      iex> change_public_address(public_address)
      %Ecto.Changeset{source: %PublicAddress{}}

  """
  def change_public_address(%PublicAddress{} = public_address) do
    PublicAddress.changeset(public_address, %{})
  end
end
