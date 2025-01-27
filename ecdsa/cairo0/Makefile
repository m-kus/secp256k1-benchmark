install:
	pip install -r scripts/requirements.txt

compile:
	cairo-compile \
		--proof_mode \
		--output target/ecdsa.casm.json src/lib.cairo

args:
	python ./scripts/gen_args.py > data/args.json

execute:
	cairo-run \
		--program target/ecdsa.casm.json \
		--program_input data/args.json \
		--layout recursive \
		--proof_mode \
		--print_info \
		--air_public_input target/public_input.json \
		--air_private_input target/private_input.json \
		--trace_file target/trace \
		--memory_file target/memory

prove:
	adapted_stwo \
		--priv_json target/private_input.json \
		--pub_json target/public_input.json \
		--proof_path target/proof.json
