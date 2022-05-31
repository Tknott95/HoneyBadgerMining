#!/bin/bash

# EXAMPLE - ./start_miner.sh  "9iBNhtz7EsNgzAS43Ad3Hie7TCsbXy2yunAncgHemTMXroXJ93g;erg.2miners.com:8888"

cd ../lolminer
cd */
ls -la

chmod +x lolMiner

WALLET_ADDR=$(echo $@ | grep -Eo '^[^;]+')
POOL_MINING=$(echo $@ | grep -Eo '[^;]*$')

echo "MINING POOL:  $POOL_MINING"
echo "MINING TO:    $WALLET_ADDR"

./lolMiner --algo AUTOLYKOS2 --pool $POOL_MINING --user $WALLET_ADDR $@ --apiport 1339
