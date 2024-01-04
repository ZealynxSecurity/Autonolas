// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {OLAS} from "../OLAS.sol";
import {veOLAS} from "../veOLAS.sol";


contract veOLASTest is Test {
    OLAS public olas;
    veOLAS public veolas;

    address public alice;
    address public bob; //owner

    uint256 constant oneOLABalance = 1; // 1 OLAS, ajusta según sea necesario
    uint256 constant twoOLABalance = 2; // 1 OLAS, ajusta según sea necesario
    uint256 constant tenOLABalance = 10; // 10 OLAS, ajusta según sea necesario
    uint256 constant oneWeek = 1 weeks; // Duración del bloqueo de una semana
    uint256 constant initialMint = 1000000;


    function setUp() public {
        olas = new OLAS();

        address randomId1 = address(olas);
        string memory randomId2 = "name";
        string memory randomId3 = "symbol";

        alice = vm.addr(1);
        bob = vm.addr(2);
        vm.prank(bob);
        veolas = new veOLAS(randomId1,randomId2,randomId3);
        olas.mint(bob, initialMint);


    }

    // Testityfuzz
    function test_createLock() public {
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

    function check_testFuzz3(uint256 amount, uint256 unlockTime) public {
        veolas.createLock(amount,unlockTime);

    }

    function testBalanceAndSupply() public {

        vm.prank(bob);
        // Transferir 10 OLAS a account
        olas.transfer(alice, tenOLABalance);
        vm.prank(bob);

        // Aprobar OLAS para el contrato veOLAS
        olas.approve(address(veolas), oneOLABalance);
        vm.prank(alice); // Impersonar account para la aprobación
        olas.approve(address(veolas), tenOLABalance);

        // Verificar suministro inicial
        assertEq(veolas.totalSupply(), 0, "El suministro total inicial no es 0");

        uint256 lockDuration = oneWeek; // Duración de 1 semana
        vm.prank(bob);
        // Crear bloqueos
        veolas.createLock(oneOLABalance, lockDuration);
        vm.prank(alice); // Impersonar account para crear bloqueo
        veolas.createLock(twoOLABalance, lockDuration);

        // Verificar suministro y balance
        uint256 balanceDeployer = veolas.getVotes(address(bob));
        uint256 balanceAccount = veolas.getVotes(alice);
        uint256 supply = veolas.totalSupplyLocked();
        uint256 sumBalance = balanceAccount + balanceDeployer;
        assertEq(supply, sumBalance, "El suministro total no coincide con la suma de los balances");

        uint256 blockNumber = block.number; // Número de bloque actual en Foundry

        // Verificar balance en un bloque específico
        balanceDeployer = veolas.balanceOfAt(address(bob), blockNumber);
        balanceAccount = veolas.balanceOfAt(alice, blockNumber);
        supply = veolas.totalSupplyAt(blockNumber);
        sumBalance = balanceAccount + balanceDeployer;
        assertEq(supply, sumBalance, "El suministro total en el bloque no coincide con la suma de los balances");
    }

    function testFuzz_BalanceAndSupply(uint256 tenOLABalance1, uint256 oneOLABalance1,uint256 twoOLABalance1, uint256 oneWeek1) public {

        vm.assume(oneOLABalance1 != 0);
        vm.assume(twoOLABalance1 != 0);
        vm.expectRevert(bytes("Overflow"));
        
        vm.prank(bob);
        // Transferir 10 OLAS a account
        olas.transfer(alice, tenOLABalance1);
        vm.prank(bob);

        // Aprobar OLAS para el contrato veOLAS
        olas.approve(address(veolas), oneOLABalance1);
        vm.prank(alice); // Impersonar account para la aprobación
        olas.approve(address(veolas), tenOLABalance1);

        // Verificar suministro inicial
        assertEq(veolas.totalSupply(), 0, "El suministro total inicial no es 0");

        uint256 lockDuration = oneWeek1; // Duración de 1 semana
        vm.assume(lockDuration != 0);
        vm.expectRevert(bytes("UnlockTimeIncorrect"));

        vm.prank(bob);
        // Crear bloqueos
        veolas.createLock(oneOLABalance1, lockDuration);
        vm.prank(alice); // Impersonar account para crear bloqueo
        veolas.createLock(twoOLABalance1, lockDuration);

        // Verificar suministro y balance
        uint256 balanceDeployer = veolas.getVotes(address(bob));
        uint256 balanceAccount = veolas.getVotes(alice);
        uint256 supply = veolas.totalSupplyLocked();
        uint256 sumBalance = balanceAccount + balanceDeployer;
        assertEq(supply, sumBalance, "El suministro total no coincide con la suma de los balances");

        uint256 blockNumber = block.number; // Número de bloque actual en Foundry

        // Verificar balance en un bloque específico
        balanceDeployer = veolas.balanceOfAt(address(bob), blockNumber);
        balanceAccount = veolas.balanceOfAt(alice, blockNumber);
        supply = veolas.totalSupplyAt(blockNumber);
        sumBalance = balanceAccount + balanceDeployer;
        assertEq(supply, sumBalance, "El suministro total en el bloque no coincide con la suma de los balances");
    }

}