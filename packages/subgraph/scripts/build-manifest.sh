#!/bin/bash

NETWORK=$1

if [ "$STAGING" ]
then
  FILE=$NETWORK'-staging.json'
else
  FILE=$NETWORK'.json'
fi

DATA=manifest/data/$FILE

HARDHAT_PACKAGE=$(node -e 'console.log(require("path").dirname(require.resolve("@scaffold-eth/hardhat/package.json")))')

echo 'Generating manifest from data file: '$DATA
cat $DATA

mustache \
  -p manifest/templates/sources/OfferFactory.yaml \
  -p manifest/templates/contracts/OfferFactory.template.yaml \
  $DATA \
  src/subgraph.template.yaml \
  | sed -e "s#\$HARDHAT_PACKAGE#$HARDHAT_PACKAGE#g" > subgraph.yaml