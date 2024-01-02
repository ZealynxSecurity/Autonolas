// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "../src/OLAS.sol";

contract EchidnaOLASAssert is OLAS {
    event Time(uint256 _indexTimeLaunch, uint256 _indexCurrentTime);

    uint256 public amount;
    address public _owner;
    address public spender;
    uint256 private mockTime = block.timestamp;  // Initialize with the current timestamp or a specific start point
    uint256 public _time;

    // Constructor can stay empty or replicate the OLAS constructor
    constructor() OLAS() {
        emit Time(timeLaunch, _currentTime());
    }

    // INVARIANT 1: Total Supply Never Exceeds Ten Year Supply Cap
    function echidna_test_total_supply_cap() public view returns (bool) {
        return totalSupply <= tenYearSupplyCap;
    }

    // INVARIANT 2: Owner and Minter Addresses are Non-Zero
    function echidna_test_non_zero_addresses() public view returns (bool) {
        return owner != address(0) && minter != address(0);
    }

    // INVARIANT 3: Inflation Control
    function echidna_test_inflation_control() public returns (bool) {
        emit Time(timeLaunch, _currentTime());
        return inflationControl(amount);
    }

    // INVARIANT 4: Remaining Supply After Mint
    function echidna_test_inflation_remainder() public returns (bool) {
        emit Time(timeLaunch, _currentTime());
        return inflationRemainder() >= 0;
    }

    // INVARIANT 5: Burn Does Not Underflow
    function echidna_test_burn_underflow() public view returns (bool) {
        return totalSupply >= 0;
    }

    // INVARIANT 6: Allowances Are Correctly Managed
    function echidna_test_allowance_management() public view returns (bool) {
        return allowance[_owner][spender] <= balanceOf[_owner];
    }

    // INVARIANT 7: Minting Does Not Exceed Yearly Inflation After 10 Years
    function echidna_test_yearly_inflation_control() public returns (bool) {
        emit Time(timeLaunch, _currentTime());

        // Calculate the dynamic supply cap based on the years passed
        uint256 currentSupplyCap = tenYearSupplyCap;
        uint256 numYears = (_currentTime() - timeLaunch) / oneYear;
        
        // After 10 years, adjust supplyCap according to the yearly inflation % set in maxMintCapFraction
        if (numYears > 9) {
            numYears -= 9; // Adjust for the first 10 years
            for (uint256 i = 0; i < numYears; ++i) {
                currentSupplyCap += (currentSupplyCap * maxMintCapFraction) / 100;
            }
        }
        
        // Check if the total supply does not exceed the dynamically calculated supply cap
        return totalSupply <= currentSupplyCap;
    }

    function setTime() public {
        mockTime = _time;
    }

    function _currentTime() internal view override returns (uint256) {
        return mockTime;
    }
}