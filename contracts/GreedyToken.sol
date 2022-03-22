// SPDX-License-Identifier:MIT

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

pragma solidity >=0.8.0;

contract GreedyToken is ERC20, Ownable {
    constructor() ERC20("GreedyToken","GdyTkn"){

    }
    function mint(address user, uint256 value) public onlyOwner{
        _mint(user, value);
    }
}