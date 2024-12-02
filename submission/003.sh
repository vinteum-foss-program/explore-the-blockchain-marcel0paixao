# How many new outputs were created by block 123,456?

block_hash=$(bitcoin-cli -rpcuser=bitcoinuser -rpcpassword=bitcoinpassword getblockhash 123456)

block_details=$(bitcoin-cli -rpcuser=bitcoinuser -rpcpassword=bitcoinpassword getblock $block_hash 2)

output_count=0

for tx in $(echo "$block_details" | jq -r '.tx[]'); do
  num_outputs=$(echo "$block_details" | jq -r ".tx[] | select(.txid == \"$tx\") | .vout | length")

  output_count=$((output_count + num_outputs))
done

echo $output_count
