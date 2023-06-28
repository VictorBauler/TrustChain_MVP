// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.9.0;

contract DexData {
    // Struct to represent token data for a specific candle interval
    struct Token {
        bytes32 ticker; // Token ticker symbol
        address tokenAddress; // Token contract address
        uint256[] candleOpens; // Array to store open prices for each candle
        uint256[] candleHighs; // Array to store high prices for each candle
        uint256[] candleLows; // Array to store low prices for each candle
        uint256[] candleCloses; // Array to store close prices for each candle
        uint256[] candleTimestamps; // Array to store timestamps for each candle
    }

    // Struct to represent a decentralized exchange (DEX)
    struct Dex {
        bytes32 name; // DEX name
        address dexAddress; // DEX contract address
        Token[] tokens; // Array to store tokens listed on the DEX
    }

    Dex[] public dexes; // Array to store all DEXs

    /**
     * @dev Function to add a new DEX with associated tokens.
     * @param _name The name of the DEX.
     * @param _dexAddress The address of the DEX contract.
     * @param _tokens An array of Token structs representing the tokens listed on the DEX.
     */
    function addDex(
        bytes32 _name,
        address _dexAddress,
        Token[] memory _tokens
    ) external {
        Dex storage newDex = dexes.push();
        newDex.name = _name;
        newDex.dexAddress = _dexAddress;
        for (uint256 i = 0; i < _tokens.length; i++) {
            Token storage newToken = newDex.tokens.push();
            newToken.ticker = _tokens[i].ticker;
            newToken.tokenAddress = _tokens[i].tokenAddress;

            uint256[] memory opens = new uint256[](
                _tokens[i].candleOpens.length
            );
            uint256[] memory highs = new uint256[](
                _tokens[i].candleHighs.length
            );
            uint256[] memory lows = new uint256[](_tokens[i].candleLows.length);
            uint256[] memory closes = new uint256[](
                _tokens[i].candleCloses.length
            );
            uint256[] memory timestamps = new uint256[](
                _tokens[i].candleTimestamps.length
            );

            for (uint256 j = 0; j < _tokens[i].candleOpens.length; j++) {
                opens[j] = _tokens[i].candleOpens[j];
                highs[j] = _tokens[i].candleHighs[j];
                lows[j] = _tokens[i].candleLows[j];
                closes[j] = _tokens[i].candleCloses[j];
                timestamps[j] = _tokens[i].candleTimestamps[j];
            }

            newToken.candleOpens = opens;
            newToken.candleHighs = highs;
            newToken.candleLows = lows;
            newToken.candleCloses = closes;
            newToken.candleTimestamps = timestamps;
        }
    }

    /**
     * @dev Function to get the details of a specific DEX.
     * @param _dexIndex The index of the DEX in the dexes array.
     * @return name The name of the DEX.
     * @return dexAddress The address of the DEX contract.
     * @return tokens An array of Token structs representing the tokens listed on the DEX.
     */

    function getDexDetails(
        uint256 _dexIndex
    )
        external
        view
        returns (bytes32 name, address dexAddress, Token[] memory tokens)
    {
        require(_dexIndex < dexes.length, "Invalid DEX index");

        Dex storage dex = dexes[_dexIndex];
        return (dex.name, dex.dexAddress, dex.tokens);
    }

    /**
     * @dev Function to get the candle data for a specific token on a DEX.
     * @param _dexIndex The index of the DEX in the dexes array.
     * @param _tokenIndex The index of the token in the tokens array of the DEX.
     * @return opens An array of open prices for each candle of the token.
     * @return highs An array of high prices for each candle of the token.
     * @return lows An array of low prices for each candle of the token.
     * @return closes An array of close prices for each candle of the token.
     * @return timestamps An array of timestamps for each candle of the token.
     */
    function getTokenCandleData(
        uint256 _dexIndex,
        uint256 _tokenIndex
    )
        external
        view
        returns (
            uint256[] memory opens,
            uint256[] memory highs,
            uint256[] memory lows,
            uint256[] memory closes,
            uint256[] memory timestamps
        )
    {
        require(_dexIndex < dexes.length, "Invalid DEX index");
        require(
            _tokenIndex < dexes[_dexIndex].tokens.length,
            "Invalid token index"
        );

        Token storage token = dexes[_dexIndex].tokens[_tokenIndex];
        return (
            token.candleOpens,
            token.candleHighs,
            token.candleLows,
            token.candleCloses,
            token.candleTimestamps
        );
    }
}
