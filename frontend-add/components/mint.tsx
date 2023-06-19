import React from "react";

const Mint = () => {
  const handleMint = async () => {
    if (window.ethereum) {
      try {
        // Request access to the user's MetaMask account
        await window.ethereum.request({
          method: "eth_requestAccounts",
        });

        // Call the minting function in your smart contract
        // Replace `YourContract` with the actual contract name or address
        const contract = await ethers.getContractFactory("YourContract");
        const deployedContract = await contract.deployed();

        // Perform the minting
        const mintTx = await deployedContract.mint();

        // Wait for the transaction to be mined
        await mintTx.wait();

        // Display success message or perform further actions
        console.log("NFT minted successfully!");
      } catch (error) {
        console.error("Error minting NFT:", error);
      }
    } else {
      console.error("MetaMask extension not detected!");
    }
  };

  return (
    <div>
      <h1>Mint NFT</h1>
      <button onClick={handleMint}>Mint</button>
    </div>
  );
};

export default Mint;
