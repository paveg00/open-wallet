const { expect } = require("chai");
const { ethers } = require("hardhat");

let owner


describe("EOA features", function () {
    
    beforeEach(async function(){

      })
    it("Send money", async function () {

        [owner, adr1] = await ethers.getSigners();

        let budget = 1000;
        
        MyERC20 = await ethers.getContractFactory("MyERC20", owner);
        hardhatERC20 = await MyERC20.deploy("lala", "blabla", budget);
     

        WalletAbstraction = await ethers.getContractFactory("WalletAbstraction", owner);
        hardhatWalletAbstraction = await WalletAbstraction.deploy(hardhatERC20.address);        
        
        expect(await hardhatWalletAbstraction.connect(owner).balance()).to.equal(0);

        // MANUAL send tokens to the EOA
        await hardhatERC20.connect(owner).transfer(hardhatWalletAbstraction.address, budget);

        expect(await hardhatWalletAbstraction.connect(owner).sendTokens(adr1.address, budget));
        expect(await hardhatERC20.balanceOf(adr1.address)).to.equal(budget);
    });
  });




describe("Rights of owners", function () {
    it("Usual case", async function () {
      const [owner, adr1, adr2] = await ethers.getSigners();

      const TrustedOwnableContract = await ethers.getContractFactory("TrustedOwnable");
      const hardhatTrustedOwnableContract = await TrustedOwnableContract.deploy();


      await hardhatTrustedOwnableContract.connect(owner).approveTruster(adr1.address);
      await hardhatTrustedOwnableContract.connect(owner).approveTruster(adr2.address);


      await hardhatTrustedOwnableContract.connect(adr1).requestChangeOwner(adr1.address);
      await hardhatTrustedOwnableContract.connect(adr1).voteForOwner(adr1.address);
      await hardhatTrustedOwnableContract.connect(adr2).voteForOwner(adr1.address);


      expect(await hardhatTrustedOwnableContract.owner()).to.equal(adr1.address);

    });
  });

