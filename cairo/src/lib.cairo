use garaga::ec_ops::{G1Point, FunctionFelt, u384, msm_g1, MSMHint, DerivePointFromXHint};

#[executable]
fn main() {
    let scalars_digits_decompositions = Option::None;
    let msm_hint = MSMHint {
        Q_low: G1Point {
            x: u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
            y: u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
        },
        Q_high: G1Point {
            x: u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
            y: u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
        },
        Q_high_shifted: G1Point {
            x: u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
            y: u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
        },
        RLCSumDlogDiv: FunctionFelt {
            a_num: array![
                u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
                u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
                u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
                u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
                u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
            ]
                .span(),
            a_den: array![
                u384 { limb0: 0x1, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
                u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
                u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
                u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
                u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
                u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
            ]
                .span(),
            b_num: array![
                u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
                u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
                u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
                u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
                u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
                u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
            ]
                .span(),
            b_den: array![
                u384 { limb0: 0x1, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
                u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
                u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
                u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
                u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
                u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
                u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
                u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
                u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
            ]
                .span(),
        },
    };
    let derive_point_from_x_hint = DerivePointFromXHint {
        y_last_attempt: u384 {
            limb0: 0x862bbbc7625bb23fe3ee10f0,
            limb1: 0x868baf0626c044f9a077a0ca,
            limb2: 0x155e74b122885e85,
            limb3: 0x0,
        },
        g_rhs_sqrt: array![
            u384 {
                limb0: 0x610f7ffe1889436670829e43,
                limb1: 0xb1f2329808ffbbfd2a7fce4c,
                limb2: 0x56c9e223dae04be9,
                limb3: 0x0,
            },
        ]
            .span(),
    };
    let points = array![
        G1Point {
            x: u384 {
                limb0: 0x393dead57bc85a6e9bb44a70,
                limb1: 0x64d4b065b3ede27cf9fb9e5c,
                limb2: 0xda670c8c69a8ce0a,
                limb3: 0x0,
            },
            y: u384 {
                limb0: 0x789872895ad7121175bd78f8,
                limb1: 0xc0deb0b56fb251e8fb5d0a8d,
                limb2: 0x3f10d670dc3297c2,
                limb3: 0x0,
            },
        },
        G1Point {
            x: u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
            y: u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
        },
    ]
        .span();
    let scalars = array![
        u256 { low: 0x0, high: 0x0 },
        u256 {
            low: 0xeb1167b367a9c3787c65c1e582e2e662, high: 0xf7c1bd874da5e709d4713d60c8a70639,
        },
    ]
        .span();

    let res = msm_g1(
        scalars_digits_decompositions, msm_hint, derive_point_from_x_hint, points, scalars, 2,
    );
    assert!(
        res == G1Point {
            x: u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
            y: u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
        },
    );
}
