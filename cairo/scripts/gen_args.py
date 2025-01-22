from coincurve import ecdsa, PrivateKey
from coincurve.utils import sha256
from garaga import garaga_rs
from garaga.definitions import CurveID, G1Point
import json

BASE = 2 << 128


def gen_msm_hint(generator_point: G1Point, pk_point: G1Point, u1: int, u2: int):
    return garaga_rs.msm_calldata_builder(
        [generator_point.x, generator_point.y, pk_point.x, pk_point.y],
        [u1, u2],
        CurveID.SECP256K1.value,
        False,  # include_digits_decomposition
        False,  # include_points_and_scalars
        False,  # serialize_as_pure_felt252_array
        False,  # risc0_mode
    )


def to_u256(value: int) -> list[int]:
    return [value % BASE, value // BASE]


def generate_args():
    sk = PrivateKey()
    msg = b"hello"

    pk_x, pk_y = sk.public_key.point()
    pk_point = G1Point(pk_x, pk_y, CurveID.SECP256K1)

    msg_hash = int.from_bytes(sha256(msg), 'big')

    signature = ecdsa.serialize_compact(
        ecdsa.der_to_cdata(sk.sign(msg))
    )
    r = int.from_bytes(signature[:32], 'big')
    s = int.from_bytes(signature[32:], 'big')

    s_inv = pow(s, -1, CurveID.SECP256K1.p)
    u1 = (msg_hash * s_inv) % CurveID.SECP256K1.p
    u2 = (r * s_inv) % CurveID.SECP256K1.p

    generator_point = G1Point.get_nG(CurveID.SECP256K1, 1)

    msm_hint = gen_msm_hint(generator_point, pk_point, u1, u2)

    res = [
        *to_u256(r),
        *to_u256(s),
        *to_u256(msg_hash),
        pk_x,
        0, 0, 0, 0, 0,
        *msm_hint
    ]
    return list(map(hex, res))


if __name__ == "__main__":
    print(json.dumps(generate_args(), indent=4))
