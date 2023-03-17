const hre = require("hardhat");
const main = async () => {
  const Eppo = await hre.ethers.getContractFactory("Eppo");
  const eppo = await Eppo.deploy();
  await eppo.deployed();

  console.log("Contract deployed to ", eppo.address);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
