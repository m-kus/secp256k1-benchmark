use garaga::signatures::ecdsa::{ECDSASignatureWithHint, is_valid_ecdsa_signature};

const SECP256K1_CURVE_ID: u32 = 2;

#[executable]
pub fn main(sigs: Array<ECDSASignatureWithHint>) {
    for sig in sigs {
        assert!(is_valid_ecdsa_signature(sig, SECP256K1_CURVE_ID));
    }
}
