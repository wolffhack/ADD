import React from "react";

const Vote = () => {
  const handleVote = async () => {
    if (window.ethereum) {
      try {
        // Request access to the user's MetaMask account
        await window.ethereum.request({
          method: "eth_requestAccounts",
        });

        // Perform the voting logic
        // Replace with your own implementation
        console.log("Vote submitted!");
      } catch (error) {
        console.error("Error submitting vote:", error);
      }
    } else {
      console.error("MetaMask extension not detected!");
    }
  };

  return (
    <div>
      <h1>Vote</h1>
      <button onClick={handleVote}>Vote</button>
    </div>
  );
};

export default Vote;
