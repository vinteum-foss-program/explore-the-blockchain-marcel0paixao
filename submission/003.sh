# How many new outputs were created by block 123,456?

#!/bin/bash

# Defina o número do bloco
BLOCK_NUMBER=123456
BLOCK_HASH=$(bitcoin-cli getblockhash $BLOCK_NUMBER)

TX_IDS=$(bitcoin-cli getblock $BLOCK_HASH true | jq -r '.tx[]')

OUTPUT_COUNT=0

for TX_ID in $TX_IDS; do
    TX=$(bitcoin-cli getrawtransaction $TX_ID true)

    NUM_OUTPUTS=$(echo $TX | jq '.vout | length')

    OUTPUT_COUNT=$((OUTPUT_COUNT + NUM_OUTPUTS))
done

echo $OUTPUT_COUNT
