// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {OLAS} from "../OLAS.sol";
import {veOLAS} from "../veOLAS.sol";


contract veOLASTest is Test {
    OLAS public olas;
    veOLAS public veolas;


    function run() public {
        olas = new OLAS();

        address randomId1 = address(olas);
        string memory randomId2 = "name";
        string memory randomId3 = "symbol";

        veolas = new veOLAS(randomId1,randomId2,randomId3);

    }

//Testityfuzz
    function check_test_createLock() public {
        veolas.createLock(11593,2293762);
        
    }

    function test2(uint256 amount, uint256 unlockTime) public {
        vm.assume(amount != 0);
        vm.assume(unlockTime != 0);
        vm.assume(unlockTime != 1);
        vm.assume(amount != 1);
        vm.assume(amount != type(uint96).max);

        veolas.createLock(amount,unlockTime);

    }
    // function test2(uint256 amount, uint256 unlockTime) public {
    //     veolas.createLock(amount,unlockTime);

    // }

}