execute:
	rm -rf target/execute && scarb --profile proving execute

prove:
	adapted_stwo --priv_json target/execute/ecdsa/air_private_input.json --pub_json target/execute/ecdsa/air_public_input.json --proof_path target/proof.json
