# How many new outputs were created by block 123,456?

#!/bin/bash

BLOCK_HEIGHT=123456
block_hash=$(bitcoin-cli getblockhash $BLOCK_HEIGHT)
block_details=$(bitcoin-cli getblock $block_hash 2)
output_count=0

for txid in $(echo "$block_details" | jq -r '.tx[]'); do
  num_outputs=$(echo "$block_details" | jq -r ".tx[] | select(.txid == \"$txid\") | .vout | length")
  output_count=$((output_count + num_outputs))
done

echo "$output_count"
