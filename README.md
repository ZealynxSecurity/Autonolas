# Installation:

```js
 git submodule update --init --recursive
```
```js
sudo forge build -force
```

# Instructions for use:

To be able to use this repository, you need to have the following installed:

- Foundry
- Halmos
- Echidna
- Medusa
- Ityfuzz
- Blazo

# Tools used:


## Foundry

### OLAS

### veOLAS


##  Halmos 

### Explanation

To successfully run the tests, it is necessary to have Foundry and Halmos installed.
In these contracts, we have employed fuzzing techniques combined with formal verification in order to conduct a much more exhaustive and higher-quality analysis, leveraging their significant advantages over using just a fuzzer.

### - OLAS

### Explanation

In this contract, we have utilized:

- A contract as the foundation for the tests, employing cheatcodes provided by Halmos to create users and random amounts distributed among them in a hierarchical structure.

- A second contract in which we have written all the test logic for the code we have tested:

  - The test, named _checkNoBackdoor, is responsible for verifying the integrity of a contract by making random calls to all of its functions with randomly generated arguments. Its primary goal is to confirm that the contract maintains a specific invariant, in this case, ensuring that if the balance of an account decreases due to random calls, the prior allocation between accounts is sufficient to cover that decrease. This prevents potential vulnerabilities and ensures compliance with the rules established in the contract.
   
      ```solidity
       function check_NoBackdoor(bytes4 selector, address caller, address other) public {}
      ```

  - The _check_transfer function verifies the operation of token transfers within a contract. It checks that transfers are executed correctly and that the balances of the involved addresses are updated appropriately. It also ensures that other addresses are not affected by the transfer operation.
 
    ```solidity
    function check_transfer(address sender, address receiver, address other, uint256 amount) public {}
    ```
  - The _check_transferFrom function is designed to verify the proper functioning of token transfers within a contract. Its purpose is to ensure that transfers are executed without errors and that the balances of the involved addresses are updated correctly. Additionally, it ensures that the transfer operations do not impact other addresses within the contract.
    ```solidity
        function check_transferFrom(address caller, address from, address to, address other, uint256 amount) public virtual {}
    ```

### - veOLAS

### Explanation

In this contract, we have utilized:

- A contract as the foundation for the tests, employing cheatcodes provided by Halmos to create users and random amounts distributed among them in a hierarchical structure.

- A second contract in which we have written all the test logic for the code we have tested:

 - The test, named _checkNoBackdoor, is responsible for verifying the integrity of a contract by making random calls to all of its functions with randomly generated arguments. Its primary goal is to confirm that the contract maintains a specific invariant, in this case, ensuring that if the balance of an account decreases due to random calls, the prior allocation between accounts is sufficient to cover that decrease. This prevents potential vulnerabilities and ensures compliance with the rules established in the contract.
   
      ```solidity
       function check_NoBackdoor(bytes4 selector, address caller, address other) public {}
      ```
## Echidna

### OLAS

### veOLAS

## Medusa

### OLAS

### veOLAS

## Ityfuzz

### Explanation

ItyFuzz is a blazing-fast EVM and MoveVM smart contract hybrid fuzzer that combines symbolic execution and fuzzing to find bugs in smart contracts offchain and onchain.

We have utilized the ityfuzz tool in various ways:
- One approach involved using the "bug()" keyword to intentionally break specific invariants within the code at particular locations.
- Another method was to integrate it within the existing assert tests of Echidna since the tool itself operates within it, aiming to enhance its capabilities by applying formal verification within the Echidna fuzzer.

![image](https://github.com/scab24/Autonolas/assets/94926493/5cfde79c-9dde-4f5a-950f-3fbe0e502630)


### OLAS

### veOLAS

