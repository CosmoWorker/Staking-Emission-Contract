// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../src/AstroCoin.sol";

contract AstroCoinTest is Test {
    AstroCoinContract ac;

    function setUp() public {
        ac = new AstroCoinContract(address(this));
    }

    function testInitialSupply()public view{
        assert(ac.totalSupply()==0);
    }

    function testFailMint()public  {
        vm.startPrank(0xf6142Eeb765187b908B1485BFc8772F24A6E2b2A);
        ac.mint(0xf6142Eeb765187b908B1485BFc8772F24A6E2b2A, 10);
    }

    function  testMint() public{  
        ac.mint(0xf6142Eeb765187b908B1485BFc8772F24A6E2b2A, 10);
        assert(ac.balanceOf(0xf6142Eeb765187b908B1485BFc8772F24A6E2b2A)==10);
    }

    function testChangeStakingContract() public{
        ac.updateStakingContract(0xf6142Eeb765187b908B1485BFc8772F24A6E2b2A);
        vm.startPrank(0xf6142Eeb765187b908B1485BFc8772F24A6E2b2A);
        ac.mint(0xf6142Eeb765187b908B1485BFc8772F24A6E2b2A, 10);
        assert(ac.balanceOf(0xf6142Eeb765187b908B1485BFc8772F24A6E2b2A)==10);
    }
}
