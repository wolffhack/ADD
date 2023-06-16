const hre = require("hardhat");

async function main() {
    console.log("Deploying contract...")
    const deal = await hre.ethers.getContractFactory("ArtworksDataDAO");
    const deall = await deal.deploy();
    await deall.deployed();
    console.log("Contract deployed in ", deall.address);



}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
