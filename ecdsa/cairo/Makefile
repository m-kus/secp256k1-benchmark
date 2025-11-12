install:
	pip install -r scripts/requirements.txt

install-stwo:
	RUSTFLAGS="-C target-cpu=native -C opt-level=3" \
		cargo install --force \
		--git https://github.com/starkware-libs/stwo-cairo \
		cairo-prove

install-stwo-run-and-prove:
	cargo +nightly-2025-07-14 install \
		--git https://github.com/starkware-libs/prover-utils \
		--rev 1cc94dcaa6922c197430a0bfad27cc80c22056e0 \
		stwo_run_and_prove

args:
	python ./scripts/gen_args.py $(NUM_SIGS) > tests/fixtures/args.json

build:
	scarb --profile proving build

execute:
	scarb --profile proving execute \
		--arguments-file data/args.json \
		--print-resource-usage \
		--output none

prove:
	cairo-prove prove target/proving/ecdsa.executable.json target/proof.json --arguments-file data/args.json

run-and-prove:
	stwo_run_and_prove \
		--program bootloaders/simple_bootloader_compiled.json \
		--program_input program_input.json \
		--prover_params_json prover_params.json \
		--proofs_dir target \
		--proof-format cairo-serde \
		--verify