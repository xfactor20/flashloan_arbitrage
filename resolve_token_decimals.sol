pragma solidity ^0.5.16;

// functionality that enables detection and resolution of decimal differences in token pairs. The decimal places are important because they determine the smallest unit that a token can be divided into. Standard BEP-20 and ERC-20 tokens typically have 18 decimal places
// Pseudo-code

function resolveDecimals(address tokenA, address tokenB, uint amountA, uint amountB) public returns (uint resolvedAmountA, uint resolvedAmountB) {
    uint decimalA = tokenA.decimals();  // retrieve decimals of token A
    uint decimalB = tokenB.decimals();  // retrieve decimals of token B

    if(decimalA > decimalB){
        //If token A has more decimals, adjust amountB
        resolvedAmountA = amountA;
        resolvedAmountB = amountB * (10 ** (decimalA - decimalB));
    }
    else if(decimalA < decimalB){
        //If token B has more decimals, adjust amountA
        resolvedAmountA = amountA * (10 ** (decimalB - decimalA));
        resolvedAmountB = amountB;
    }
    else {
        //If both tokens have same decimals, no adjustment required
        resolvedAmountA = amountA;
        resolvedAmountB = amountB;
    }

    return (resolvedAmountA, resolvedAmountB);
}
