#!/bin/bash
set -e
cd "`dirname $0`"
source flags.sh
cargo build --all --target wasm32-unknown-unknown --release
cp target/wasm32-unknown-unknown/release/*.wasm ./res/

near delete nft.junnon.testnet junnon.testnet 
near create-account nft.junnon.testnet --masterAccount junnon.testnet --initialBalance 100

near deploy nft.junnon.testnet --wasmFile res/non_fungible_token.wasm --initFunction new_default_meta --initArgs '{"owner_id":"junnon.testnet"}'

near call nft.junnon.testnet nft_mint '{"receiver_id":"junnon.testnet"}' --accountId junnon.testnet --depositYocto  10000000000000000000000

