from brownie import accounts, config, DexData, web3


def main():
    # Load the deployer account
    deployer = accounts[0]

    # Deploy the contract
    dex_data = DexData.deploy({"from": deployer})

    # Print the contract address
    print("Contract deployed at:", dex_data.address)

    # Convert dex_name to bytes32
    dex_name_bytes32 = web3.toBytes(text="MyDEX")  # Replace "MyDEX" with your desired DEX name

    # Add DEX details
    dex_address = "0x1234567890123456789012345678901234567890"  # Replace with your actual DEX address
    tokens = [
        (
            web3.toBytes(text="TKN1"),
            "0x1234567890123456789012345678901234567891",  # Replace with your token address
            [100, 150, 200],  # Example candle opens
            [120, 180, 220],  # Example candle highs
            [80, 130, 180],  # Example candle lows
            [110, 160, 210],  # Example candle closes
            [1630000000, 1630003600, 1630007200]  # Example candle timestamps
        ),
        (
            web3.toBytes(text="TKN2"),
            "0x1234567890123456789012345678901234567892",  # Replace with your token address
            [100, 150, 200],  # Example candle opens
            [120, 180, 220],  # Example candle highs
            [80, 130, 180],  # Example candle lows
            [110, 160, 210],  # Example candle closes
            [1630000000, 1630086400, 1630172800]  # Example candle timestamps
        ),
    ]
    dex_data.addDex(dex_name_bytes32, dex_address, tokens)

    # Retrieve and print DEX details
    dex_index = 0  # Replace with the desired DEX index
    name, address, listed_tokens = dex_data.getDexDetails(dex_index)
    print("DEX Details:")
    print("Name:", web3.toText(name))
    print("Address:", address)
    print("Listed Tokens:")
    for token in listed_tokens:
        print("     Token Name:", web3.toText(token[0]))
        print("     Token Address:", token[1])
        print("     Token Candle Data:")
        print("     Opens:", token[2])
        print("     Highs:", token[3])
        print("     Lows:", token[4])
        print("     Closes:", token[5])
        print("     Timestamps:", token[6])
        print("     --------------------")

if __name__ == "__main__":
    main()
