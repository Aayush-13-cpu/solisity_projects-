async function main() {
  const VendingMachine = await ethers.getContractFactory("VendingMachine");
  const vm = await VendingMachine.deploy();
  await vm.deployed();
  console.log("VendingMachine deployed to:", vm.address);
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
