// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.9.0;

contract DexData {
    struct Candle {
        uint256 open;
        uint256 high;
        uint256 low;
        uint256 close;
        uint256 timestamp;
    }

    struct CandleData {
        uint256 interval;
        Candle[] candles;
    }

    struct Token {
        bytes32 ticker;
        address tokenAddress;
        CandleData[] candles;
    }

    struct Dex {
        bytes32 name;
        address dexAddress;
        Token[] tokens;
    }

    Dex[] public dexes;

    function addDex(
        bytes32 _name,
        address _dexAddress,
        Token[] memory _tokens
    ) external {
        dexes.push(Dex(_name, _dexAddress, _tokens));
    }

    function addCandle(
        uint256 _dexIndex,
        uint256 _tokenIndex,
        uint256 _candleInterval,
        uint256 _open,
        uint256 _high,
        uint256 _low,
        uint256 _close,
        uint256 _timestamp
    ) external {
        require(_dexIndex < dexes.length, "Invalid Dex index");
        require(
            _tokenIndex < dexes[_dexIndex].tokens.length,
            "Invalid Token index"
        );

        Candle memory newCandle = Candle(
            _open,
            _high,
            _low,
            _close,
            _timestamp
        );
        dexes[_dexIndex].tokens[_tokenIndex].candles.push(
            CandleData(_candleInterval, newCandle)
        );
    }

    function getCandle(
        uint256 _dexIndex,
        uint256 _tokenIndex,
        uint256 _candleIndex
    )
        external
        view
        returns (
            uint256 open,
            uint256 high,
            uint256 low,
            uint256 close,
            uint256 timestamp
        )
    {
        require(_dexIndex < dexes.length, "Invalid Dex index");
        require(
            _tokenIndex < dexes[_dexIndex].tokens.length,
            "Invalid Token index"
        );
        require(
            _candleIndex < dexes[_dexIndex].tokens[_tokenIndex].candles.length,
            "Invalid Candle index"
        );

        Candle memory candle = dexes[_dexIndex]
            .tokens[_tokenIndex]
            .candles[_candleIndex]
            .candles[0];
        return (
            candle.open,
            candle.high,
            candle.low,
            candle.close,
            candle.timestamp
        );
    }

    function getCandleCount(
        uint256 _dexIndex,
        uint256 _tokenIndex
    ) external view returns (uint256) {
        require(_dexIndex < dexes.length, "Invalid Dex index");
        require(
            _tokenIndex < dexes[_dexIndex].tokens.length,
            "Invalid Token index"
        );

        return dexes[_dexIndex].tokens[_tokenIndex].candles.length;
    }
}
