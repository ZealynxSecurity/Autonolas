// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {SymTest} from "halmos-cheatcodes/SymTest.sol";
import {console2} from "forge-std/Script.sol";


import {OLAS} from "../OLAS.sol";
import {veOLAS} from "../veOLAS.sol";


contract HalmosveOLASTest is Test, SymTest {
    OLAS public olas;
    veOLAS public veolas;

    // address public alice;
    // address public bob; //owner

    address caller = svm.createAddress('caller'); // create a symbolic address
    address others = svm.createAddress('others');

    // uint256 constant oneOLABalance = 1; // 1 OLAS, ajusta según sea necesario
    // uint256 constant twoOLABalance = 2; // 1 OLAS, ajusta según sea necesario
    // uint256 constant tenOLABalance = 10; // 10 OLAS, ajusta según sea necesario
    // uint256 constant oneWeek = 1 weeks; // Duración del bloqueo de una semana
    // uint256 constant initialMint = 1000000;

    // uint256 oneOLABalance = svm.createUint256('1');
    // uint256 twoOLABalance = svm.createUint256('2');
    // uint256 tenOLABalance = svm.createUint256('10');
    // uint256 oneWeek = svm.createUint256('7');
    uint256 initialMint = svm.createUint256('1000000');


    function setUp() public {
        olas = new OLAS();


        caller = address(0x1000);
        others = address(0x2000);

        vm.prank(caller);
        veolas = new veOLAS(address(olas),"name","symbol");
        olas.mint(caller, initialMint);


    }
    function check_priimero() public {
        console2.log("holaa");
    }
    
    function check_testFuzz3(uint256 amount, uint256 unlockTime) public {
        veolas.createLock(amount,unlockTime);

    }

    // function check_testFuzz_HalmosBalanceAndSupply(uint256 tenOLABalance1, uint256 oneOLABalance1,uint256 twoOLABalance1,uint256 oneWeek) public {

    //     // vm.assume(oneOLABalance1 != 0);
    //     // vm.assume(twoOLABalance1 != 0);
    //     // vm.expectRevert(bytes("Overflow"));
    //     // vm.expectRevert(bytes("UnlockTimeIncorrect"));
        
    //     vm.prank(caller);
    //     // Transferir 10 OLAS a account
    //     olas.transfer(others, tenOLABalance1);
    //     vm.prank(caller);

    //     // Aprobar OLAS para el contrato veOLAS
    //     olas.approve(address(veolas), oneOLABalance1);
    //     vm.prank(others); // Impersonar account para la aprobación
    //     olas.approve(address(veolas), tenOLABalance1);

    //     // Verificar suministro inicial
    //     uint256 lockDuration = oneWeek; // Duración de 1 semana
    //     // vm.assume(lockDuration != 0);

    //     vm.prank(caller);
    //     // Crear bloqueos
    //     veolas.createLock(oneOLABalance1, lockDuration);
    //     vm.prank(others); // Impersonar account para crear bloqueo
    //     veolas.createLock(twoOLABalance1, lockDuration);

    //     // Verificar suministro y balance
    //     uint256 balanceDeployer = veolas.getVotes(address(caller));
    //     uint256 balanceAccount = veolas.getVotes(others);
    //     uint256 supply = veolas.totalSupplyLocked();
    //     uint256 sumBalance = balanceAccount + balanceDeployer;
        
    //     assert(supply == sumBalance);

    //     uint256 blockNumber = block.number; // Número de bloque actual en Foundry

    //     // Verificar balance en un bloque específico
    //     balanceDeployer = veolas.balanceOfAt(address(caller), blockNumber);
    //     balanceAccount = veolas.balanceOfAt(others, blockNumber);

    //     supply = veolas.totalSupplyAt(blockNumber);
    //     sumBalance = balanceAccount + balanceDeployer;

    //     assert(supply == sumBalance);
    // }

}