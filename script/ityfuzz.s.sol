// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {OLAS} from "../src/OLAS.sol";
import {veOLAS} from "../src/veOLAS.sol";


contract _castLogPayloadViewToPure(fnIn);OLASScript is Script {
    OLAS public olas;
    veOLAS public veolas;

    event PlayerEncoded(address indexed a, string indexed b, string indexed c);
    event cons(bytes const);


    function run() public {
        olas = new OLAS();

        address randomId1 = address(olas);
        string memory randomId2 = "name";
        string memory randomId3 = "symbol";

        bytes memory const = abi.encode(randomId1,randomId2,randomId3);

        veolas = new veOLAS(randomId1,randomId2,randomId3);

        console2.log( "AddressOLAS", address(olas));
        console2.log( "AddressveOLAS", address(veolas));

        emit cons(const);
        emit PlayerEncoded(randomId1, randomId2, randomId3);
    }
}
