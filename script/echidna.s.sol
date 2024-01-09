// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {EchidnaVeOLASAssert} from "../src/Echidna/EchidnaVeOLASAssert.sol";


contract SEchidnaVeOLASAssert is Script {
    EchidnaVeOLASAssert public echidna;

    // event PlayerEncoded(address indexed a, string indexed b, string indexed c);
    // event cons(bytes const);


    function run() public {
        // address randomId1 = address(olas);
        // string memory randomId2 = "name";
        // string memory randomId3 = "symbol";

        // bytes memory const = abi.encode(randomId1,randomId2,randomId3);
        echidna = new EchidnaVeOLASAssert();

        console2.log( "AddressEchidnaVeOLASAssert", address(echidna));

        // emit cons(const);
        // emit PlayerEncoded(randomId1, randomId2, randomId3);
    }
}

//address => 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f