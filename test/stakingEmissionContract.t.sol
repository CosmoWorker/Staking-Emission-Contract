// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../src/stakingEmissionContract.sol";
import "../src/AstroCoin.sol";

contract stakingEmissionContractTest is Test{
    receive() external payable{}
    stakingEmissionContract c;
    AstroCoinContract t;

    function setUp()public {
        t=new AstroCoinContract(address(this));
        c=new stakingEmissionContract(IAstroToken(address(t)));
        t.updateStakingContract(address(c));
    }

    function testStake()public {
        c.stake{value:200}();
        assertEq(c.balanceOf(address(this)), 200);
    }

    function testUnstake()public {
        c.stake{value: 200}();
        c.unstake(100);
        assertEq(c.balanceOf(address(this)), 100);
    }

    function testFailUnstake() public{
        c.stake{value: 200}();
        c.unstake(300);
    }

    function testGetRewards() public{
        c.stake{value: 10}();
        vm.warp(block.timestamp+1);
        assert(c.getRewards()== 10);
    }

    function testAdditionalGetRewards()public {
        c.stake{value: 10}();
        vm.warp(block.timestamp + 1);
        console.log(block.timestamp);
        c.stake{value: 5}();
        vm.warp(block.timestamp+1);
        c.unstake(3);
        vm.warp(block.timestamp+1);
        assert(c.getRewards()==37);
    }

    function testClaimRewards() public{
        c.stake{value: 10}();
        vm.warp(block.timestamp+2);
        c.claimRewards();
        assert(t.balanceOf(address(this))==20);
    }
}