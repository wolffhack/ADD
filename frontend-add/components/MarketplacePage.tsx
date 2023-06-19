import React from 'react';
import styles from './MarketplacePage.module.css';

const MarketplacePage = () => {
  const handleBuy = (itemId: number) => {
    // Logic for buying an item
    console.log(`Buying item with ID: ${itemId}`);
  };

  const handleSell = () => {
    // Logic for selling an item
    console.log('Selling item');
  };

  return (
    <div className={styles.container}>
      <h1 className={styles.heading}>Marketplace</h1>
      <div className={styles.listedItems}>
        <h2>Listed Items</h2>
        <ul className={styles.itemList}>
          <li className={styles.item}>
            <div className={styles.itemContent}>
              <h3>Item 1</h3>
              <p className={styles.price}>Price: 0.1 ETH</p>
              <p className={styles.artist}>Artist: John Doe</p>
              <button className={styles.buyButton} onClick={() => handleBuy(1)}>Buy</button>
            </div>
          </li>
          <li className={styles.item}>
            <div className={styles.itemContent}>
              <h3>Item 2</h3>
              <p className={styles.price}>Price: 0.05 ETH</p>
              <p className={styles.artist}>Artist: Jane Smith</p>
              <button className={styles.buyButton} onClick={() => handleBuy(2)}>Buy</button>
            </div>
          </li>
        </ul>
      </div>
      <div>
        <button className={styles.sellButton} onClick={handleSell}>Sell</button>
      </div>
    </div>
  );
};

export default MarketplacePage;
