import React,  {useEffect} from "react";
import NavBar from "@/components/navbar";
import Hero from "@/components/Hero";
import Footer from "@/components/Footer";
import ReactDOM from "react-dom";
import Mint from "@/components/mint";
import Marketplace from "@/components/Marketplace";
import Vote from "@/components/vote";
import { BrowserRouter as Router, Switch, Route, Routes } from "react-router-dom";
//import Route from "@/components/Routes.js";
//import MarketplacePage from './MarketplacePage';

export default function InvestirDao(){
  return(
<>
<NavBar/>
<Hero/>
<Mint/>
<Marketplace/>
<Vote/>
<Footer/>
</>
  )

  ReactDOM.render(
    <React.StrictMode>
      <Mint />
    </React.StrictMode>,
    document.getElementById("root")
  );

  ReactDOM.render(
    <React.StrictMode>
      <Route />
    </React.StrictMode>,
    document.getElementById("root")
  );

}
