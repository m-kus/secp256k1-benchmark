%builtins range_check bitwise

from starkware.cairo.common.cairo_builtins import BitwiseBuiltin
from starkware.cairo.common.cairo_secp.signature import get_point_from_x, get_generator_point, div_mod_n, validate_signature_entry
from starkware.cairo.common.cairo_secp.ec import ec_add, ec_mul, ec_negate
from starkware.cairo.common.cairo_secp.ec_point import EcPoint
from starkware.cairo.common.cairo_secp.bigint3 import BigInt3

func main{range_check_ptr, bitwise_ptr: BitwiseBuiltin*}() {
    alloc_locals;

    local r: BigInt3;
    local s: BigInt3;
    local msg_hash: BigInt3;
    local pk_x: BigInt3;
    local pk_v: felt;

    %{
        from starkware.cairo.common.cairo_secp.secp_utils import split

        segments.write_arg(ids.r.address_, split(program_input['r']))
        segments.write_arg(ids.s.address_, split(program_input['s']))
        segments.write_arg(ids.msg_hash.address_, split(program_input['msg_hash']))
        segments.write_arg(ids.pk_x.address_, split(program_input['pk_x']))
        ids.pk_v = int(program_input['pk_v']);
    %}

    validate_signature_entry(r);
    validate_signature_entry(s);

    let (generator_point: EcPoint) = get_generator_point();
    let (pk_point: EcPoint) = get_point_from_x(x=pk_x, v=pk_v);

    let (u1: BigInt3) = div_mod_n(msg_hash, s);
    let (u2: BigInt3) = div_mod_n(r, s);

    let (p1: EcPoint) = ec_mul(generator_point, u1);
    let (p2: EcPoint) = ec_mul(pk_point, u2);
    let (p3: EcPoint) = ec_add(p1, p2);

    let (p3_x: BigInt3) = div_mod_n(p3.x, BigInt3(d0=1, d1=0, d2=0));
    assert p3_x = r;

    return ();
}
