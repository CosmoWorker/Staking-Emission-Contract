// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "../src/AstroCoin.sol";

interface IAstroToken{
    function mint(address account, uint256 amount) external;
}

contract stakingEmissionContract{
    uint public constant REWARD_PER_SEC_PER_ETH=1;
    mapping(address=>uint) balances;
    mapping (address=>uint) unclaimedRewards;
    mapping(address=>uint) lastUpdateTime;
    IAstroToken public astroToken;

    constructor(IAstroToken _token){
        astroToken=_token;
    }

    function stake()public payable{
        require(msg.value>0, "Should stake more than 0");
        if(lastUpdateTime[msg.sender]==0){
            lastUpdateTime[msg.sender]=block.timestamp;
        }else{
            unclaimedRewards[msg.sender]+=(block.timestamp-lastUpdateTime[msg.sender])*balances[msg.sender]*REWARD_PER_SEC_PER_ETH;
            lastUpdateTime[msg.sender]=block.timestamp;
        }
        balances[msg.sender]+= msg.value;
    }   

    function unstake(uint _amount)public {
        require(_amount<=balances[msg.sender], "Not enough staked to unstake");

        unclaimedRewards[msg.sender]+=(block.timestamp-lastUpdateTime[msg.sender])*balances[msg.sender]*REWARD_PER_SEC_PER_ETH;
        lastUpdateTime[msg.sender]=block.timestamp;

        payable(msg.sender).transfer(_amount);
        balances[msg.sender]-=_amount;
    }

    function getRewards()public view returns (uint){
        uint currentReward=unclaimedRewards[msg.sender];
        uint updateTime=lastUpdateTime[msg.sender];
        uint newReward=(block.timestamp-updateTime)*balances[msg.sender]*REWARD_PER_SEC_PER_ETH; //add multiplier
        return currentReward+newReward;
    }

    function claimRewards()public{
        uint currentReward=unclaimedRewards[msg.sender];
        uint updateTime=lastUpdateTime[msg.sender];
        uint newReward=(block.timestamp-updateTime)*balances[msg.sender]*REWARD_PER_SEC_PER_ETH; //add multiplier as well
        //transfer current rewards + new rewards, unclaimed rewards in astro coin
        astroToken.mint(msg.sender, currentReward+newReward);
        unclaimedRewards[msg.sender]=0;
        lastUpdateTime[msg.sender]=block.timestamp;
    }

    function balanceOf(address _address)public view returns (uint){
        return balances[_address];
    }
}