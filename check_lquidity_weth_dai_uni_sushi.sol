pragma solidity ^0.8.0;

interface IUniswapV2Pair {
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
}

contract MyContract {
    IUniswapV2Pair public uniswapPair;
    IUniswapV2Pair public sushiswapPair;

    constructor(address _uniswapPair, address _sushiswapPair) {
        uniswapPair = IUniswapV2Pair(_uniswapPair);
        sushiswapPair = IUniswapV2Pair(_sushiswapPair);
    }

    function checkUniswapLiquidity() public view returns (uint112, uint112) {
        (uint112 reserve0, uint112 reserve1,) = uniswapPair.getReserves();
        return (reserve0, reserve1);
    }

    function checkSushiswapLiquidity() public view returns (uint112, uint112) {
        (uint112 reserve0, uint112 reserve1,) = sushiswapPair.getReserves();
        return (reserve0, reserve1);
    }
}
