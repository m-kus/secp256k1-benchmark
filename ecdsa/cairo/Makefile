install:
	pip install -r scripts/requirements.txt

install-stwo:
	RUSTFLAGS="-C target-cpu=native -C opt-level=3" \
		cargo install --force \
		--git https://github.com/starkware-libs/stwo-cairo \
		cairo-prove

args:
	python ./scripts/gen_args.py > data/args.json

execute:
	scarb --profile proving execute \
		--arguments-file data/args.json \
		--print-resource-usage \
		--output none

prove:
	cairo-prove prove target/proving/ecdsa.executable.json target/proof.json --arguments-file data/args.json
