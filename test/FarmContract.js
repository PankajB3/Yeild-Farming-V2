const {expect} = require('chai');
const {ethers} = require('hardhat');
const {deployMockContract} = require("ethereum-waffle/mock-contract");

describe('Farm Contract', () => { 
    beforeEach(async()=>{
        const [owner, addr1, adddr2] = await ethers.getSigners();
        const farmContract = await ethers.getContractFactory("FarmContract");
        const greedyToken = await ethers.getContractFactory("GreedyToken");
        
    })
    it('',async()=>{
        
    })
 })