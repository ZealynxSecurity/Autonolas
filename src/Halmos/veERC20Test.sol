// SPDX-License-Identifier: AGPL-3.0
pragma solidity >=0.8.0 <0.9.0;

import {SymTest} from "halmos-cheatcodes/SymTest.sol";
import {Test} from "forge-std/Test.sol";
import {Script, console2} from "forge-std/Script.sol";


import {IERCveOLAS} from "src/Interfaces/IERCveOLAS.sol";


abstract contract veERC20Test is SymTest, Test {
    // erc20 token address
    address internal token;
    address internal olas;

    // token holders
    address[] internal holders;
    event Result (uint256 parametroa, uint256 parametrob);
    function setUp() public virtual;


//=================================================
// BACKDOR
//=================================================

    function _checkNoBackdoor(bytes4 selector, bytes memory args, address caller, address other) public virtual {
        // consider two arbitrary distinct accounts
        vm.assume(other != caller);

        // record their current balances
        uint256 oldBalanceOther = IERCveOLAS(olas).balanceOf(other);

        uint256 oldAllowance = IERCveOLAS(olas).allowance(other, caller);

        // consider an arbitrary function call to the token from the caller
        vm.prank(caller);
        (bool success,) = address(token).call(abi.encodePacked(selector, args));
        vm.assume(success);

        uint256 newBalanceOther = IERCveOLAS(olas).balanceOf(other);

        // ensure that the caller cannot spend other' tokens without approvals
        if (newBalanceOther < oldBalanceOther) {
            assert(oldAllowance >= oldBalanceOther - newBalanceOther);
        }
    }

//=================================================
// TRANSFER / TRANSFERFROM
//=================================================

//     function _check_transfer(address sender, address receiver, address other, uint256 amount) public virtual {
//         // consider other that are neither sender or receiver
//         require(other != sender);
//         require(other != receiver);

//         // record their current balance
//         uint256 oldBalanceSender   = IERCveOLAS(token).balanceOf(sender);
//         uint256 oldBalanceReceiver = IERCveOLAS(token).balanceOf(receiver);
//         uint256 oldBalanceOther   = IERCveOLAS(token).balanceOf(other);

//         vm.prank(sender);
//         IERCveOLAS(token).transfer(receiver, amount);

//         if (sender != receiver) {
//             assert(IERCveOLAS(token).balanceOf(sender) <= oldBalanceSender); // ensure no subtraction overflow
//             assert(IERCveOLAS(token).balanceOf(sender) == oldBalanceSender - amount);
//             assert(IERCveOLAS(token).balanceOf(receiver) >= oldBalanceReceiver); // ensure no addition overflow
//             assert(IERCveOLAS(token).balanceOf(receiver) == oldBalanceReceiver + amount);
//         } else {
//             // sender and receiver may be the same
//             assert(IERCveOLAS(token).balanceOf(sender) == oldBalanceSender);
//             assert(IERCveOLAS(token).balanceOf(receiver) == oldBalanceReceiver);
//         }
//         // make sure other balance is not affected
//         assert(IERCveOLAS(token).balanceOf(other) == oldBalanceOther);
//     }

//     function _check_transferFrom(address caller, address from, address to, address other, uint256 amount) public virtual {
//         require(other != from);
//         require(other != to);

//         uint256 oldBalanceFrom   = IERCveOLAS(token).balanceOf(from);
//         uint256 oldBalanceTo     = IERCveOLAS(token).balanceOf(to);
//         uint256 oldBalanceOther = IERCveOLAS(token).balanceOf(other);

//         uint256 oldAllowance = IERCveOLAS(token).allowance(from, caller);

//         vm.prank(caller);
//         IERCveOLAS(token).transferFrom(from, to, amount);

//         if (from != to) {
//             assert(IERCveOLAS(token).balanceOf(from) <= oldBalanceFrom);
//             assert(IERCveOLAS(token).balanceOf(from) == oldBalanceFrom - amount);
//             assert(IERCveOLAS(token).balanceOf(to) >= oldBalanceTo);
//             assert(IERCveOLAS(token).balanceOf(to) == oldBalanceTo + amount);

//             assert(oldAllowance >= amount); // ensure allowance was enough
//             assert(oldAllowance == type(uint256).max || IERCveOLAS(token).allowance(from, caller) == oldAllowance - amount); // allowance decreases if not max
//         } else {
//             assert(IERCveOLAS(token).balanceOf(from) == oldBalanceFrom);
//             assert(IERCveOLAS(token).balanceOf(to) == oldBalanceTo);
//         }
//         assert(IERCveOLAS(token).balanceOf(other) == oldBalanceOther);
//     }


// //=================================================
// // APPROVE / IN DECREASSEALOWANCE 
// //=================================================

//         // Allowance should be modified correctly via increase/decrease
//     function _check_test_ERC20_setAndIncreaseAllowance(
//         bytes4 selector,
//         bytes memory args,
//         address caller,
//         address target,
//         uint256 initialAmount,
//         uint256 increaseAmount
//     ) public {

//         require(caller != target);

//         vm.startPrank(caller);
//         bool r = IERCveOLAS(token).approve(target, initialAmount);
//         assertTrue(r,"Failed to set initial allowance via approve");
//         assertEq(
//             IERCveOLAS(token).allowance(address(this), target),
//             initialAmount,
//             "Allowance not set correctly"
//         );
//       // consider an arbitrary function call to the token from the caller
//         // (bool success,) = address(token).call(abi.encodePacked(selector, args));
//         // vm.assume(success);

//         bool t = IERCveOLAS(token).increaseAllowance(target, increaseAmount);
//         assertTrue(t,"Failed to increase allowance");

//         uint256 parametroa = IERCveOLAS(token).allowance(address(this), target);
//         uint256 parametrob = initialAmount + increaseAmount;
//         vm.stopPrank();
//         console2.log("aaaa",parametroa);
//         console2.log("bbb",parametrob);

//         assertEq(
//             parametroa,
//             parametrob,
//             "Allowance not increased correctly"
//         );
//         emit Result( parametroa, parametrob);

//     }

//     function _checkApprove(bytes4 selector, bytes memory args, address caller, address other) public virtual {
//         // consider two arbitrary distinct accounts
//         vm.assume(other != caller);

//         // record their current balances
//         uint256 oldBalanceOther = IERCveOLAS(token).balanceOf(other);

//         uint256 oldAllowance = IERCveOLAS(token).allowance(other, caller);

//         // consider an arbitrary function call to the token from the caller
//         vm.startPrank(caller);
//         // (bool success,) = address(token).call(abi.encodePacked(other, args));
//         // vm.assume(success);
//         IERCveOLAS(token).increaseAllowance(other, svm.createUint256("deadline"));
//         IERCveOLAS(token).decreaseAllowance(other, svm.createUint256("deadline"));

//         uint256 newBalanceOther = IERCveOLAS(token).balanceOf(other);
//         uint256 newAllowance = IERCveOLAS(token).allowance(other, caller);
//         vm.stopPrank();


//         // ensure that the caller cannot spend other' tokens without approvals
//         if (newBalanceOther < oldBalanceOther) {
//             assert(oldAllowance >= newAllowance);
//         }
//     }
}