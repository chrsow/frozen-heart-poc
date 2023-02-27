pragma circom 2.0.0;

template ZKFactor() {  
    signal input p;
    signal input q;
    signal output n <== p * q;
}

component main = ZKFactor();