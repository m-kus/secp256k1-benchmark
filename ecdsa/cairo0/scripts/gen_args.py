from coincurve import ecdsa, PrivateKey
from coincurve.utils import sha256
import json


def generate_args():
    sk = PrivateKey()
    msg = b"hello"

    pk_x, pk_y = sk.public_key.point()
    pk_v = pk_y % 2

    msg_hash = int.from_bytes(sha256(msg), 'big')

    signature = ecdsa.serialize_compact(
        ecdsa.der_to_cdata(sk.sign(msg))
    )
    r = int.from_bytes(signature[:32], 'big')
    s = int.from_bytes(signature[32:], 'big')

    return {
        "pk_x": pk_x,
        "pk_v": pk_v,
        "msg_hash": msg_hash,
        "r": r,
        "s": s,
    }


if __name__ == "__main__":
    print(json.dumps(generate_args(), indent=4))
