# How many new outputs were created by block 123,456?

xpub="xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2"

descriptor="tr($xpub/100)"

taproot_address=$(bitcoin-cli -rpcuser=bitcoinuser -rpcpassword=bitcoinpassword getaddressinfo "$descriptor" | jq -r '.address')

echo "Taproot address at index 100: $taproot_address"
