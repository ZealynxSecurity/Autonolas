// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "../OLAS.sol";

contract EchidnaOLASAssert {
    event Time(uint256 _indexTimeLaunch, uint256 _indexCurrentTime);
    event Amount(uint256 amount);

    OLAS olas;
    uint256 private mockTime = block.timestamp;  // Initialize with the current timestamp or a specific start point

    // Constructor can stay empty or replicate the OLAS constructor
    constructor() {
        olas = new OLAS();
        emit Time(olas.timeLaunch(), block.timestamp);
    }

    // INVARIANT 1: Total Supply Never Exceeds Ten Year Supply Cap
    function assert_total_supply_cap() public view {
        assert(olas.totalSupply() <= olas.tenYearSupplyCap());
    }

    // INVARIANT 2: Owner and Minter Addresses are Non-Zero
    function assert_non_zero_addresses() public view {
        assert(olas.owner() != address(0) && olas.minter() != address(0));
    }

    // // INVARIANT 3: Inflation Control
    // function assert_inflation_control(uint256 amount) public {
    //     emit Time(olas.timeLaunch(), block.timestamp);
    //     emit Amount(amount);
    //     assert(olas.inflationControl(amount));
    // }

    // INVARIANT 4: Remaining Supply After Mint
    function assert_inflation_remainder() public {
        emit Time(olas.timeLaunch(), block.timestamp);
        assert(olas.inflationRemainder() >= 0);
    }

    // INVARIANT 5: Burn Does Not Underflow
    function assert_burn_underflow() public view {
        assert(olas.totalSupply() >= 0);
    }

    // INVARIANT 6: Allowances Are Correctly Managed
    function assert_allowance_management(address _owner, address spender) public view {
        assert(olas.allowance(_owner, spender) <= olas.balanceOf(_owner));
    }

    // INVARIANT 7: Minting Does Not Exceed Yearly Inflation After 10 Years
    function assert_yearly_inflation_control() public {
        emit Time(olas.timeLaunch(), block.timestamp);

        // Calculate the dynamic supply cap based on the years passed
        uint256 currentSupplyCap = olas.tenYearSupplyCap();
        uint256 numYears = (block.timestamp - olas.timeLaunch()) / olas.oneYear();
        
        // After 10 years, adjust supplyCap according to the yearly inflation % set in maxMintCapFraction
        if (numYears > 9) {
            numYears -= 9; // Adjust for the first 10 years
            for (uint256 i = 0; i < numYears; ++i) {
                currentSupplyCap += (currentSupplyCap * olas.maxMintCapFraction()) / 100;
            }
        }
        
        // Check if the total supply does not exceed the dynamically calculated supply cap
        assert(olas.totalSupply() <= currentSupplyCap);
    }


     /// Tests for external functions

    function assert_owner_can_change_owner(address newOwner) public {
        address originalOwner = olas.owner();
        // Attempt to change the owner to a new address
        if (newOwner == address(0) || newOwner == originalOwner) {
            // Not a valid test case, return true
            assert(true);
        }

        // Attempt to change the owner
        olas.changeOwner(newOwner);

        assert(olas.owner() == newOwner);

        // Reset the owner to the original owner for the next test
        olas.changeOwner(originalOwner);
    }

    // Inflation remainder should be less than or equal to ten year supply cap minus total supply
    function assert_inflation_remainder_within_cap() public view {
        assert(olas.inflationRemainder() <= olas.tenYearSupplyCap() - olas.totalSupply());
    }


}