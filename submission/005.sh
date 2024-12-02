# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`


TXID="37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517"

TX_DATA=$(bitcoin-cli getrawtransaction "$TXID" 1 2>/dev/null)

PUBLIC_KEYS=$(echo "$TX_DATA" | jq -r '.vin[].txinwitness[1]' | grep -E '^[a-fA-F0-9]{66}$')

PUBLIC_KEYS=$(echo "$PUBLIC_KEYS" | head -n 4)

PUBLIC_KEYS_JSON=$(echo "$PUBLIC_KEYS" | jq -R . | jq -s .)

CREATED=$(bitcoin-cli createmultisig 1 "$PUBLIC_KEYS_JSON")

echo "$CREATED" | jq -r '.address'
