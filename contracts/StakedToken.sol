// SPDX-License-Identifier:MIT

pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract StakedToken is ERC20{
    constructor() ERC20("StakedToken","STK"){}

    function mint(address user, uint256 val) external{
        _mint(user, val);
    }
}