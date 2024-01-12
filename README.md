
# Installation

To be able to use this repository, you need to have the following installed:

- Foundry
 -  https://book.getfoundry.sh/getting-started/installation
- Halmos
 -  https://github.com/a16z/halmos/tree/main
- Echidna
 -   https://github.com/crytic/echidna?tab=readme-ov-file#installation
- Medusa
 - https://github.com/crytic/medusa?tab=readme-ov-file#installation
- Ityfuzz
 - https://docs.ityfuzz.rs/installation-and-building
- Blazo
 - https://github.com/fuzzland/blazo

# Init:

```js
 git submodule update --init --recursive
```
```js
sudo forge build -force
```

  
# Tools used:


## Foundry

### Explanation
We have been conducting fuzzing tests and invariant tests to verify the proper functionality of the contract.

### - OLASTest

```
forge test --mc OLASTest
```

<img width="433" alt="image" src="https://github.com/scab24/Autonolas/assets/94926493/e29e61cc-cfcd-47a5-a9e1-894aff067760">

### - veOLASTest

```
forge test --mc veOLASTest
```
<img width="355" alt="image" src="https://github.com/scab24/Autonolas/assets/94926493/1573d66a-fac0-4899-bead-d3e2fc47571f">


##  Halmos 


To successfully run the tests, it is necessary to have Foundry and Halmos installed.
In these contracts, we have employed fuzzing techniques combined with formal verification in order to conduct a much more exhaustive and higher-quality analysis, leveraging their significant advantages over using just a fuzzer.

### - HalmosOLAS

### Explanation

In this contract, we have utilized:

- A contract as the foundation for the tests, employing cheatcodes provided by Halmos to create users and random amounts distributed among them in a hierarchical structure.

- A second contract in which we have written all the test logic for the code we have tested:

  ```
  halmos --contract HalmosOLAS --solver-timeout-assertion 0
  ```

  <img width="585" alt="image" src="https://github.com/scab24/Autonolas/assets/94926493/5c7a702a-508e-425a-a91f-9ef09805f208">
   


### - HalmosveOLAS

### Explanation

In this contract, we have utilized:

- A contract as the foundation for the tests, employing cheatcodes provided by Halmos to create users and random amounts distributed among them in a hierarchical structure.

```
sudo halmos --contract HalmosveOLAS --solver-timeout-assertion 0
```

- A second contract in which we have written all the test logic for the code we have tested:
<img width="456" alt="image" src="https://github.com/scab24/Autonolas/assets/94926493/e5a42293-1d72-46b8-b9fd-c9581511a0fd">


## Echidna

### - EchidnaOLAS

```
echidna src/Echidna/EchidnaOLAS.sol --contract EchidnaOLAS
```

<img width="606" alt="image" src="https://github.com/scab24/Autonolas/assets/94926493/c7069971-95c6-43da-bfe2-93fc8f5d3817">

### - EchidnaOLASAssert

```
echidna src/Echidna/EchidnaOLASAssert.sol --contract EchidnaOLASAssert --test-mode assertion
```

<img width="603" alt="image" src="https://github.com/scab24/Autonolas/assets/94926493/4410d337-cb90-499f-9f41-b449b4317b8b">

### - EchidnaVeOLASAssert

```
echidna src/Echidna/EchidnaVeOLASAssert.sol --contract EchidnaVeOLASAssert --test-mode assertion
```

<img width="606" alt="image" src="https://github.com/scab24/Autonolas/assets/94926493/7a7b3761-26a9-4f25-98c0-69b937d84a06">


## Medusa

### EchidnaOLASAssert

<img width="350" alt="image" src="https://github.com/scab24/Autonolas/assets/94926493/3f42bd26-00d2-42ef-bde6-5e9afe231fb5">


```
sudo medusa fuzz --assertion-mode
```

<img width="425" alt="image" src="https://github.com/scab24/Autonolas/assets/94926493/07add054-ebe6-4102-8fc6-a1690506a0e7">


### EchidnaVeOLASAssert

<img width="317" alt="image" src="https://github.com/scab24/Autonolas/assets/94926493/8eb63b56-0737-47ac-97da-fe49af4f151a">

```
sudo medusa fuzz --assertion-mode
```

<img width="544" alt="image" src="https://github.com/scab24/Autonolas/assets/94926493/246f03a2-f4fa-41fb-964e-5812b1be7917">


## Ityfuzz

### Explanation

ItyFuzz is a blazing-fast EVM and MoveVM smart contract hybrid fuzzer that combines symbolic execution and fuzzing to find bugs in smart contracts offchain and onchain.

We have utilized the ityfuzz tool in various ways:
- One approach involved using the "bug()" keyword to intentionally break specific invariants within the code at particular locations.
- Another method was to integrate it within the existing assert tests of Echidna since the tool itself operates within it, aiming to enhance its capabilities by applying formal verification within the Echidna fuzzer.

<img width="575" alt="image" src="https://github.com/scab24/Autonolas/assets/94926493/bfb708b5-18ba-4464-9085-c52d360cd01e">

```
sudo blazo contest2
```
```
ityfuzz evm --builder-artifacts-file './results.json' --offchain-config-file './tt.json' -t "a" -f
```

![image](https://github.com/scab24/Autonolas/assets/94926493/5cfde79c-9dde-4f5a-950f-3fbe0e502630)


