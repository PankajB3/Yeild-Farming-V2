// SPDX-License-IdentifierL:MIT

pragma solidity >=0.8.0;

import "./GreedyToken.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract FarmContract {

    IERC20 public stakedToken;
    GreedyToken public gdyTkn;

    mapping(address=>bool) alreadyStaked; // wether already staked or not
    mapping(address=>uint256) stakedBalance; //already staked balance.
    mapping(address=>uint256) startTime; // time track
    mapping(address=>uint256) yeildTokenBalance; // Greedy Token balance of user.

    event Stake(address indexed from, uint256 amount);
    event Unstake(address indexed from, uint256 amount);
    event YieldWithdraw(address indexed to, uint256 amount);

    constructor(IERC20 stakedAddress, GreedyToken GreedyTokenAddr){
        stakedToken = stakedAddress;
        gdyTkn = GreedyTokenAddr;
    }

    function getTimeDifference(address user) internal view returns(uint256){
        uint256 end = block.timestamp;
        uint diff = end - startTime[user];
        return diff;
    }

    function getYeildBalance(address user) internal view returns(uint256){
        uint256 timeDiff = getTimeDifference(user) * 10**18;
        uint256 rate = 86400; // seconds in a day
        uint256 timeRate = timeDiff / rate;
        uint256 yeild = (stakedBalance[user] * timeRate) / 10**18;
        return yeild;
    }

    function stake(uint256 amt) public{
        require(amt>0 && stakedToken.balanceOf(msg.sender) >= amt, "Add appropriate Balance.");

        if(alreadyStaked[msg.sender]){
            // if the tokens are already staked, lets find out the unrealized yeild of this user.
            yeildTokenBalance[msg.sender] += getYeildBalance(msg.sender);
        }
        // Realization of yeild is done
        // Now tranmsfer tokens from user to this FarmContract
        stakedToken.transferFrom(msg.sender, address(this), amt);
        stakedBalance[msg.sender] += amt;
        startTime[msg.sender] = block.timestamp;
        alreadyStaked[msg.sender] = true;
        emit Stake(msg.sender, amt);
    }   

    function unstake(uint256 amt) public{
        require(alreadyStaked[msg.sender] == true && stakedBalance[msg.sender] >= amt, "Can't unstake this amount");
        uint256 yeild = getYeildBalance(msg.sender);
        uint256 cAmt = amt;
        amt = 0;
        stakedBalance[msg.sender] -= cAmt;
        stakedToken.transfer(msg.sender, cAmt);
        yeildTokenBalance[msg.sender] += yeild;
        if(stakedBalance[msg.sender] >0){
            alreadyStaked[msg.sender] = false;
        }
        emit Unstake(msg.sender, cAmt);
    }

    function withdrawYeild() public{
        uint256 totalYeild = getYeildBalance(msg.sender);
        require(stakedBalance[msg.sender]>0 || totalYeild >0, "Nothing to Withdraw.");
        if(yeildTokenBalance[msg.sender] != 0){
            uint256 bal = yeildTokenBalance[msg.sender];
            yeildTokenBalance[msg.sender] = 0;
            totalYeild += bal;
        }
        emit YieldWithdraw(msg.sender, totalYeild);
    }
    
}