#!/bin/bash


POOL=erg.2miners.com:8888	
WALLET=9iBNhtz7EsNgzAS43Ad3Hie7TCsbXy2yunAncgHemTMXroXJ93g

cd ../lolminer

cd */
ls -la

# bring in as wallet/pool



#   w  - wallet addr
#   p  - pool
while getopts ':p:' OPTION; do
  case "$OPTION" in
    p)
      #WALLET_ADDR=$(echo $OPTARG | grep -Eo '^[^;]+')
      #echo $WALLET_ADDR
      # POOL_MINING=$(echo $OPTARG | grep -Eo '[^;]*$')
      #echo $POOL_MINING 
      # ./lolMiner --algo AUTOLYKOS2 --pool $POOL --user $WALLET $@ --apiport 1339

      ;;
    ?)
      echo "script usage: $(basename \$0) [-l] [-h] [-a somevalue]" >&2
      exit 1
      ;;
  esac
done


# chmod +x lolMiner
# echo `./lolMiner --algo AUTOLYKOS2 --pool $POOL --user $WALLET $@ --apiport 1339`

WALLET_ADDR=$(echo $@ | grep -Eo '^[^;]+')
POOL_MINING=$(echo $@ | grep -Eo '[^;]*$')

echo "MINING POOL:  $POOL_MINING"
echo "MINING TO:    $WALLET_ADDR"

./lolMiner --algo AUTOLYKOS2 --pool $POOL_MINING --user $WALLET_ADDR $@ --apiport 1339
