import React from 'react';
import { Switch, Route } from 'react-router-dom';
import MarketplacePage from "@/components/MarketplacePage";

const Route = () => {
  return (
    <div>
      <Switch>
        <Route path="/marketplace" component= MarketplacePage() />
      </Switch>
    </div>
  );
};

export default Route;
