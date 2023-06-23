// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/UnsafeDelegatecall.sol";

contract UnsafeDelegatecallTest is Test {
    UnsafeDelegatecall public unsafeDelegatecall;
    Lib public lib;
    Attack public attack;

    function setUp() public {
        lib = new Lib();
        console.log("Lib deployed at ", address(lib));

        unsafeDelegatecall = new UnsafeDelegatecall(lib);
        console.log("UnsafeDelegatecall deployed at ", address(unsafeDelegatecall));        
    }

    function testAttack() public {
        address alice = address(1);
        vm.prank(alice);
        attack = new Attack(address(unsafeDelegatecall));
        console.log("Attack deployed at ", address(attack));

        console.log("Before UnsafeDelegatecall owner is ", unsafeDelegatecall.owner());
        attack.attack();
        console.log("After UnsafeDelegatecall owner is ", unsafeDelegatecall.owner());
    }

}
