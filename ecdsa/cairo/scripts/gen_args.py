from coincurve import ecdsa, PrivateKey
from coincurve.utils import sha256
from garaga.starknet.tests_and_calldata_generators.signatures import ECDSASignature
from garaga.definitions import CurveID
import json


def generate_args():
    # Generate new private key
    sk = PrivateKey()
    # Choose signed message
    msg = b"hello"
    # Get public key coordinates
    pk_x, pk_y = sk.public_key.point()
    # Hash message
    msg_hash = int.from_bytes(sha256(msg), 'big')
    # Produce signature and serialize in recoverable format (r, s, v)
    signature = sk.sign_recoverable(msg)
    # Convert signature to the according Garaga structure
    sig = ECDSASignature(
        r=int.from_bytes(signature[:32], 'big'),
        s=int.from_bytes(signature[32:64], 'big'),
        v=int(signature[64]),
        px=pk_x,
        py=pk_y,
        z=msg_hash,
        curve_id=CurveID.SECP256K1,
    )
    # Check that signature is valid
    assert sig.is_valid()
    # Serialize with Cairo serde
    args = sig.serialize_with_hints()
    # Return as hex array
    return list(map(hex, args))


if __name__ == "__main__":
    res = generate_args()
    print(json.dumps(res, indent=4))
