# ECDSA with Garaga/Cairo1

## Installation

Requires [Scarb 2.12](https://docs.swmansion.com/scarb/download.html).

Install Python script dependencies:
```sh
make install
```

Install Stwo prover:
```sh
make install-stwo
```

## Build the program and prepare args

Build Cairo program:
```sh
scarb build
```

Generate args — ECDSA signature with extra data (hints) required for faster verification (in ZK context):
```sh
make args
```

## Execute and prove

Execute the program with the args:
```sh
make execute
```

Prove the program (the proof will be written to `target/proof.json`):
```sh
make prove
```
