# Which tx in block 257,343 spends the coinbase output of block 256,128?

block1=$(bitcoin-cli getblockhash 256128)
coinbase_tx=$(bitcoin-cli getblock $block1 | jq -r '.tx[0]')
block2=$(bitcoin-cli getblockhash 257343)
transactions=$(bitcoin-cli getblock $block2 | jq -r '.tx[]')

for tx in $transactions; do
  inputs=$(bitcoin-cli getrawtransaction $tx 1 | jq -r '.vin[].txid')
  if [[ $inputs == *"$coinbase_tx"* ]]; then
    echo $tx
    break
  fi
done
