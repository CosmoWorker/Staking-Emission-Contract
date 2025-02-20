# <h1 align="center"> Forge - Staking Emission Contract with Token</h1>
## Overview
This contract allows users to stake and unstake Ethereum(ETH) and earn rewards in the form of an ERC20 token, AstroCoin (🧑🏼‍🚀). This contracts facilitates staking, unstaking and reward claiming while holding their ETH by staking. It contains comprehensive tests which pass the contract ability to provide those above said features.
## Features
 * Staking ETH
 * Reward Emission (ERC20 token)
 * Unstaking ETH
 * Claiming Rewards
 * Security- Built-in Checks

## Getting Started

Click "Use this template" on [GitHub](https://github.com/foundry-rs/forge-template) to create a new repository with this repo as the initial state.

Or, if your repo already exists, run:
```sh
forge init
forge build
forge test
```

## Writing your first test

All you need is to `import forge-std/Test.sol` and then inherit it from your test contract. Forge-std's Test contract comes with a pre-instatiated [cheatcodes environment](https://book.getfoundry.sh/cheatcodes/), the `vm`. It also has support for [ds-test](https://book.getfoundry.sh/reference/ds-test.html)-style logs and assertions. Finally, it supports Hardhat's [console.log](https://github.com/brockelmore/forge-std/blob/master/src/console.sol). The logging functionalities require `-vvvv`.

```solidity
pragma solidity 0.8.10;

import "forge-std/Test.sol";

contract ContractTest is Test {
    function testExample() public {
        vm.roll(100);
        console.log(1);
        emit log("hi");
        assertTrue(true);
    }
}
```

## Development

This project uses [Foundry](https://getfoundry.sh). See the [book](https://book.getfoundry.sh/getting-started/installation.html) for instructions on how to install and use Foundry.
