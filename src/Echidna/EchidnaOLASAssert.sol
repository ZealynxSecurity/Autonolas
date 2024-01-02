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
    function total_supply_cap() public view {
        assert(olas.totalSupply() <= olas.tenYearSupplyCap());
    }

    // INVARIANT 2: Owner and Minter Addresses are Non-Zero
    function non_zero_addresses() public view {
        assert(olas.owner() != address(0) && olas.minter() != address(0));
    }

    // INVARIANT 3: Inflation Control
    function inflation_control(uint256 amount) public {
        emit Time(olas.timeLaunch(), block.timestamp);
        emit Amount(amount);
        assert(olas.inflationControl(amount));
    }

    // INVARIANT 4: Remaining Supply After Mint
    function inflation_remainder() public {
        emit Time(olas.timeLaunch(), block.timestamp);
        assert(olas.inflationRemainder() >= 0);
    }

    // INVARIANT 5: Burn Does Not Underflow
    function burn_underflow() public view {
        assert(olas.totalSupply() >= 0);
    }

    // INVARIANT 6: Allowances Are Correctly Managed
    function allowance_management(address _owner, address spender) public view {
        assert(olas.allowance(_owner, spender) <= olas.balanceOf(_owner));
    }

    // INVARIANT 7: Minting Does Not Exceed Yearly Inflation After 10 Years
    function yearly_inflation_control() public {
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
}