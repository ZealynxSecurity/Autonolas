// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.15;

import {Test} from "forge-std/Test.sol";
import "../OLAS.sol";

contract CounterTest is Test {
    OLAS public olas;

    function setUp() public {
        olas = new OLAS();
    }

    /// Fuzzers
    function check_testFuzz_InflationControl(uint256 amount) public {
        olas.inflationControl(amount);
        assert(amount <= olas.inflationRemainder());
    }

    function testFuzz_onlyOwnerCanChangeOwner(address randomAddress) public {
        address originalOwner = olas.owner();

        // Attempt to change the owner to a random non-zero address that is not the current owner
        if (randomAddress != address(0) && randomAddress != originalOwner) {
            // Impersonate a random address and try to change the owner
            vm.prank(randomAddress);
            try olas.changeOwner(randomAddress) {
                // If the random address is not the original owner, this should fail
                assert(randomAddress != originalOwner);
            } catch {}

            // Impersonate the original owner and change the owner successfully
            vm.prank(originalOwner);
            olas.changeOwner(randomAddress);
            assert(olas.owner() == randomAddress);

            // Change the owner back to the original owner
            vm.prank(randomAddress);
            olas.changeOwner(originalOwner);
        }
    }


    /// Invariant tests
    function invariant_ownerIsNonZero() public {
        assert(olas.owner() != address(0));
    }

    function invariant_minterIsNeverZero() public {
        assert(olas.minter() != address(0));
    }



}
