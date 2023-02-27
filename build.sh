#!/bin/sh

echo "################ BUILD ################"
npm install

if [ ! -e ./build ]; then
    mkdir build
fi

if [ ! -e ./circuits/powersOfTau28_hez_final_15.ptau ]; then
    echo "#### Download Powers of Tau ####"
    wget -q https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_15.ptau -P circuits
fi

echo "#### Compile circuit ####"
circom circuits/ZKFactor.circom --r1cs --wasm --output build 1>/dev/null

echo "#### Compute witness ####"
cd build/ZKFactor_js
node generate_witness.js ZKFactor.wasm ../../circuits/ZKFactor_input.json witness.wtns
cd ../..

version=0.4.15
echo "#### Download snarkJS v$version (vulnerable to the frozen heart) ####"
npm install snarkjs@$version 1>/dev/null

echo "#### Use the vulnerable snarkJS version to setup the verifiying key ####"
node ./node_modules/snarkjs/build/cli.cjs plonk setup ./build/ZKFactor.r1cs ./circuits/powersOfTau28_hez_final_15.ptau ./build/ZKFactor_final.zkey 1>/dev/null
node ./node_modules/snarkjs/build/cli.cjs zkey export verificationkey ./build/ZKFactor_final.zkey ./build/vkey.json

echo "################ DONE ################"