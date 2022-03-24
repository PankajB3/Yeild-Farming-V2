const {expect} = require('chai');
const {ethers} = require('hardhat');
const {deployMockContract} = require("ethereum-waffle/mock-contract");
const stakedTkn = require("@openzeppelin/contracts/token/ERC20/IERC20.sol/IERC20.json");


describe('Farm Contract', () => { 
    const daiAmount = ethers.utils.parseEther("25000");
    beforeEach(async()=>{
        const [owner, addr1, adddr2] = await ethers.getSigners();
        const farmContract = await ethers.getContractFactory("FarmContract");
        const greedyToken = await ethers.getContractFactory("GreedyToken");
        const stakTkn = await ethers
    })
    it('',async()=>{
        
    })
 })