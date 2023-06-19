import React from "react";
import MarketplacePage from "@/components/MarketplacePage"


const Marketplace = () => {
  const openMarketplaceWindow = () => {
    window.open("/marketplace", "MarketplacePage");
  };

  return (
    <div>
      <h1>Marketplace</h1>
      <button onClick={openMarketplaceWindow}>Open Marketplace</button>
    </div>

  );
};

export default Marketplace;
