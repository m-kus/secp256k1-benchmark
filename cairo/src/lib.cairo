use garaga::definitions::SECP256K1;
use garaga::ec_ops::{
    DerivePointFromXHint, G1Point, MSMHint, derive_ec_point_from_X, msm_g1, u384,
};
use garaga::basic_field_ops::{inv_mod_p, mul_mod_p};
use core::circuit::{CircuitModulus, u96};

pub const SECP256K1_G1_GENERATOR: G1Point = G1Point {
    x: u384 { limb0: 0x1, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    y: u384 { limb0: 0x2, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
};

#[derive(Drop, Serde)]
struct Arguments {
    r: u384,
    s: u384,
    msg_hash: u384,
    pk_x: felt252,
    pk_derive_hint: DerivePointFromXHint,
    msm_hint: MSMHint,
    msm_derive_hint: DerivePointFromXHint,
}

#[executable]
fn main(args: Array<felt252>) {
    let mut arguments = args.span();
    let Arguments {
        r, s, msg_hash, pk_x, pk_derive_hint, msm_hint, msm_derive_hint,
    } = Serde::deserialize(ref arguments).expect('failed to deserialize');

    // TODO: validate r, s

    let pk_point = derive_ec_point_from_X(
        pk_x, pk_derive_hint.y_last_attempt, pk_derive_hint.g_rhs_sqrt, 2,
    );

    let p: [u96; 4] = [SECP256K1.p.limb0, SECP256K1.p.limb1, SECP256K1.p.limb2, SECP256K1.p.limb3];
    let modulus = TryInto::<[u96; 4], CircuitModulus>::try_into(p).unwrap();

    let s_inv = inv_mod_p(s, modulus);
    let u1: u256 = mul_mod_p(msg_hash, s_inv, modulus).try_into().unwrap();
    let u2: u256 = mul_mod_p(r, s_inv, modulus).try_into().unwrap();

    let points = array![SECP256K1_G1_GENERATOR, pk_point].span();
    let scalars = array![u1, u2].span();

    let res = msm_g1(
        Option::None, msm_hint, msm_derive_hint, points, scalars, 2,
    );
    assert_eq!(res.x, r);
}
