from coincurve import PrivateKey
from coincurve.utils import sha256
from garaga import garaga_rs
from garaga.definitions import CurveID, G1Point, CURVES
from bip340 import schnorr_sign
import json
import sys

TWO128 = 2**128
TWO192 = 2**192


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
    return [value % TWO128, value // TWO128]


def to_u384(value: int) -> list[int]:
    return [value % TWO192, value // TWO192]


def generate_args(target: str):
    # Using https://github.com/bitcoin/bips/blob/master/bip-0340/test-vectors.csv
    sk = bytes.fromhex("0000000000000000000000000000000000000000000000000000000000000003")
    aux_rand = bytes.fromhex("0000000000000000000000000000000000000000000000000000000000000000")
    msg = bytes.fromhex("0000000000000000000000000000000000000000000000000000000000000000")

    e, pk_x, pk_y, signature = schnorr_sign(msg, sk, aux_rand)
    
    r = int.from_bytes(signature[:32], 'big')
    s = int.from_bytes(signature[32:], 'big')

    n = CURVES[CurveID.SECP256K1.value].n
    e_neg = n - e

    generator_point = G1Point.get_nG(CurveID.SECP256K1, 1)
    pk_point = G1Point(pk_x, pk_y, CurveID.SECP256K1)

    # MSM + derive point from X hint
    hint = gen_msm_hint(generator_point, pk_point, s, e_neg)

    res = [
        *to_u256(r),
        *to_u256(s),
        *to_u256(e),
        *to_u384(pk_x),
        *to_u384(pk_y),
        *hint[1:]  # remove `include_digits_decomposition` flag
    ]

    if target == "cairo-run":
        return [res]
    elif target == "execute":
        return [hex(len(res))] + list(map(hex, res))
    else:
        raise NotImplementedError(target)


if __name__ == "__main__":
    res = generate_args(sys.argv[1] if len(sys.argv) > 1 else "cairo-run")
    print(json.dumps(res, indent=4))
