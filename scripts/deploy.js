const hre = require("hardhat");

async function main() {
  const CertifyChain = await hre.ethers.getContractFactory("CertifyChain");
  const certifyChain = await CertifyChain.deploy();

  await certifyChain.deployed();

  console.log("CertifyChain deployed to:", certifyChain.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
