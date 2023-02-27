# frozen-heart-poc

A Proof-of-Concept for [the Frozen Heart Vulnerability in Plonk](https://blog.trailofbits.com/2022/04/18/the-frozen-heart-vulnerability-in-plonk/) on [SnarkJS](https://github.com/iden3/snarkjs) implementation (v0.4.15). In this PoC, we will forge a Plonk proof to convince the verifier that we know two factors of a random integer even though we don't really know it.

The [Frozen Heart Vulnerability](https://blog.trailofbits.com/2022/04/13/part-1-coordinated-disclosure-of-vulnerabilities-affecting-girault-bulletproofs-and-plonk/) by [Trail of Bits](https://twitter.com/trailofbits) is a bug class where insecure implementations of the [Fiat-Shamir transformation](https://en.wikipedia.org/wiki/Fiat%E2%80%93Shamir_heuristic) would allow a malicious prover to forge a proof in such a way that the verifier will accept it. While the public inputs are randomly produced in the example of the original blog post, a sophisticated attacker could be more clever on selecting wire values to get the public inputs as desired. The vulnerability could arise in various proof systems (Girault, Bulletproofs, Plonk, etc.), in this PoC, we domostrate a PoC of the vulnerability in Plonk proof.

### Build
Make sure you have [Circom](https://docs.circom.io/), [NodeJS](https://nodejs.org/) and [NPM](https://www.npmjs.com/) installed (any version of these softwares should work), then run the following command to build the PoC.

```
git clone https://github.com/chrsow/frozen-heart-poc
cd frozen-heart-poc
./build.sh
```

### Run the PoC
```
npm run exploit
```

```sh
# > frozen-heart@1.0.0 exploit
# > npx tsc && node src/exploit.js

# #### Goal: prove that we know the factors of n without reavealing its factors (n === p * q) to the verifier
# #### Submit a valid proof with the knowledge of private inputs (factors of "n")
# ## Private Inputs (factors p, q): p = 14131697022969285607, q = 14781699601595105827
# ## p * q === 208890500254287832136014517513752931989
# [+] You really know the factor of 208890500254287832136014517513752931989!
# ################ HERE WE GO ################
# #### Submit a forge proof without the knowledge of private inputs (factors of a random "n")
# [+] You really know the factor of 10590450084067612247393057396231008614287484040058187609770642683754037255182!
# #### We have successfully convinced the verifier that we konw the factors of 10590450084067612247393057396231008614287484040058187609770642683754037255182
# #### Even though we have no idea what are its factors
```