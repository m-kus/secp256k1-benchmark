install:
	pip install -r scripts/requirements.txt

args:
	python ./scripts/gen_args.py > data/args.json
	python ./scripts/gen_args.py execute > data/args_execute.json

execute:
	rm -rf target/execute && scarb --profile proving execute --verbose --print-program-output --arguments-file data/args_execute.json

run:
	scarb cairo-run --arguments-file data/args.json --print-resource-usage

prove:
	adapted_stwo --priv_json target/execute/ecdsa/air_private_input.json --pub_json target/execute/ecdsa/air_public_input.json --proof_path target/proof.json
