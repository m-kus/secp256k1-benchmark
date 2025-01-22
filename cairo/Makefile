install:
	pip install -r scripts/requirements.txt

args:
	python ./scripts/gen_args.py > data/args.json

execute:
	rm -rf target/execute && scarb --profile proving execute --arguments-file data/args.json

prove:
	adapted_stwo --priv_json target/execute/ecdsa/air_private_input.json --pub_json target/execute/ecdsa/air_public_input.json --proof_path target/proof.json
