# ECDSA benchmark

Comparing different approaches to verifying ECDSA signatures in Cairo, and measuring performance versus available proving toolchains.

## Install

### Cairo runner

```
cargo install --git https://github.com/m-kus/cairo-vm --rev 6c23578739108f823510601a2097efb985d4149b cairo1-run
```

Cairo core library:

https://docs.swmansion.com/scarb/docs/reference/global-directories.html#cache-directory

```sh
ln -s $HOME/Library/Caches/com.swmansion.scarb/registry/std/v2.8.2/core cairo/corelib 
```

### Cairo0 runner

Make sure you have Python 3.9 installed locally/in venv.

```sh
pip install cairo-lang
```

### Stwo prover

Make sure you have the latest Rust nightly toolchain installed.

```sh
RUSTFLAGS="-C target-cpu=native -C opt-level=3" cargo install --git https://github.com/starkware-libs/stwo-cairo adapted_stwo
```

### Risc0 toolchain

Follow the instructions from https://dev.risczero.com/api/zkvm/install

### SP1 toolchain

See instructions at https://docs.succinct.xyz/getting-started/install.html

## Run

### Cairo0

```sh
# Compile Cairo0 program
make compile

# Generate execution trace
make execute

# Prove with Stwo
make prove
```
