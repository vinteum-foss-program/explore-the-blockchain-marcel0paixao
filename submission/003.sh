# How many new outputs were created by block 123,456?

# Get the block hash for block number 123,456
block_hash=$(bitcoin-cli getblockhash 123456)

# Retrieve the block details using the block hash
block_details=$(bitcoin-cli getblock $block_hash 2)

# Initialize a counter for the outputs
output_count=0

# Iterate over each transaction in the block
for txid in $(echo $block_details | jq -r '.tx[]'); do
  # For each transaction, get the number of outputs
  tx_details=$(bitcoin-cli getrawtransaction $txid 1)
  num_outputs=$(echo $tx_details | jq '.vout | length')
  
  # Add the number of outputs to the counter
  output_count=$((output_count + num_outputs))
done

# Output the total number of new outputs
echo $output_count