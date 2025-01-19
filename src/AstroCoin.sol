// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract AstroCoinContract is ERC20{
    address stakingContract;
    address owner;

    constructor (address _stakingContract) ERC20("Astro", "ASR") {
        stakingContract=_stakingContract;
        owner=msg.sender;
    }

    function mint(address account, uint256 value) public{
        require(msg.sender==stakingContract);
        _mint(account, value);
    }

    function updateStakingContract(address _stakingContract) public{
        require(msg.sender==owner);
        stakingContract=_stakingContract;
    }

}
