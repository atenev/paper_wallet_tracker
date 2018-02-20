defmodule CryptoWatch.BlockchainInfo do
  def getBTCPrice(currency) do
    %{^currency => %{"last" => price}} = getResponse("https://blockchain.info/ticker")
    price
  end

  def getBalance(address) do
    %{^address => %{"final_balance" => final_balance}} =
      getResponse("https://blockchain.info/balance?active=" <> address)

    final_balance * 0.00000001
  end

  # Helper functions

  # Returns decoded json response from a web api
  defp getResponse(api_address) do
    {:ok, %HTTPoison.Response{body: blockchain_info_responce}} = HTTPoison.get(api_address)

    case JSON.decode(blockchain_info_responce) do
      {:ok, %{} = decoded_blockchain_info} -> decoded_blockchain_info
      {:error, {:unexpected_token, _}} -> getResponse(api_address)
    end

    # decoded_blockchain_info
  end
end
