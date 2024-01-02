// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {OLAS} from "../src/OLAS.sol";

contract OLASScript is Script {
    OLAS public olas;

    // event PlayerEncoded(bytes32 indexed a, bytes32 indexed b, bytes32 indexed c);
    // event cons(bytes const);


    function run() public {
        // bytes32 randomId1 = "1";
        // bytes32 randomId2 = "2";
        // bytes32 randomId3 = "3";

        // bytes memory const = abi.encode(randomId1,randomId2,randomId3);

        olas = new OLAS();
        console2.log( "Address", address(olas));

        // emit cons(const);
        // emit PlayerEncoded(randomId1, randomId2, randomId3);
    }
}

//address => 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f