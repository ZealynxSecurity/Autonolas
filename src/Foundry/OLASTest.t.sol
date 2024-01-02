// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.15;

import {Test} from "forge-std/Test.sol";
import "../OLAS.sol";

contract CounterTest is Test {
    OLAS public olas;

    function setUp() public {
        olas = new OLAS();
    }

    function prove_testFuzz_InflationControl(uint256 amount) public {
        olas.inflationControl(amount);
        assert(amount <= olas.inflationRemainder());
    }

}
