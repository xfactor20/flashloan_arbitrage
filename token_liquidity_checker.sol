pragma solidity >=0.6.0 <0.8.0;


// check the liquidity of a token pair and also calculate the necessary liquidity for a potential trade given a slippage tolerance. 
// NOTE: Needs decimal resolution prior to execution otherwise 

import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Pair.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract LiquidityChecker {
    function checkLiquidityAndCalculateRequired(
        address pairAddress,
        uint tradeSize,
        uint slippageTolerance
    )
        public
        view
        returns (uint reserve0, uint reserve1, uint requiredLiquidity)
    {
        IUniswapV2Pair pair = IUniswapV2Pair(pairAddress);
        (reserve0, reserve1,) = pair.getReserves();

        // Assuming tradeSize is for token0 and we get token1
        // This also assumes the tokens have the same decimals, which is not always true
        requiredLiquidity = tradeSize * reserve1 / reserve0 * (10000 + slippageTolerance) / 10000;

        return (reserve0, reserve1, requiredLiquidity);
    }


// Resolve token decimal spots
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
