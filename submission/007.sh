# Only one single output remains unspent from block 123,321. What address was it sent to?

block_number=123321

block_hash=$(bitcoin-cli getblockhash "$block_number")

transactions=$(bitcoin-cli getblock "$block_hash" | jq -r '.tx[]')

for txid in $transactions; do
  raw_tx=$(bitcoin-cli getrawtransaction "$txid" 2)

  echo "$raw_tx" | jq -c '.vout[]' | while read -r output; do
    n=$(echo "$output" | jq -r '.n')
    value=$(echo "$output" | jq -r '.value')
    address=$(echo "$output" | jq -r '.scriptPubKey.address // empty')

    is_unspent=$(bitcoin-cli gettxout "$txid" "$n")

    if [ -n "$is_unspent" ]; then
      echo "$address"
    fi
  done
done
