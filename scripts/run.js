const hre = require("hardhat");
const main = async () => {
  const [owner, randomPerson] = await hre.ethers.getSigners();
  const Eppo = await hre.ethers.getContractFactory("Eppo");
  const eppo = await Eppo.deploy();
  await eppo.deployed();

  console.log("Contract deployed to ", eppo.address);
  console.log("Contract deployed by ", owner.address);

  console.log("Testing Starts...");

  let txn = await eppo.transfer(randomPerson.address, {
    value: hre.ethers.utils.parseEther("1"),
  });
  await txn.wait();

  txn = await eppo.owner();
  console.log("owner", txn);

  txn = await eppo.connect(randomPerson).getHistory(randomPerson.address);
  var date = new Date(txn[0].time.toNumber());
  var dateFormat =
    date.getHours() + ":" + date.getMinutes() + ", " + date.toDateString();

  console.log("Time : ", dateFormat);
  console.log("Client : ", txn[0].client);
  console.log("Pro : ", txn[0].professional);
  const amt = hre.ethers.utils.formatEther(txn[0].amount);
  console.log("Amount : ", amt);
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
