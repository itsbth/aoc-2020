use std::fs;

#[inline]
fn extract_and_shift(n: u8, s: i32) -> u32 {
    if s >= 0 {
        (!n as u32 & 4) << s
    } else {
        (!n as u32 & 4) >> s.abs()
    }
}

pub fn id_to_int<'t>(ids: &'t [u8]) -> impl Iterator<Item = u32> + 't {
    // 10 bytes id + lf
    ids.chunks(11).map(|n| {
        extract_and_shift(n[0], 7)
            | extract_and_shift(n[1], 6)
            | extract_and_shift(n[2], 5)
            | extract_and_shift(n[3], 4)
            | extract_and_shift(n[4], 3)
            | extract_and_shift(n[5], 2)
            | extract_and_shift(n[6], 1)
            | extract_and_shift(n[7], 0)
            | extract_and_shift(n[8], -1)
            | extract_and_shift(n[9], -2)
    })
}

fn main() {
    let contents =
        fs::read_to_string(std::env::args().nth(1).unwrap_or("../sample".to_owned())).unwrap();
    let (mn, mx, total) = id_to_int(contents.as_bytes())
        .fold((u32::MAX, u32::MIN, 0), |(mn, mx, total), id| {
            (mn.min(id), mx.max(id), total + id)
        });
    println!("part 1: {}", mx);
    println!("part 2: {}", ((mn + mx) / 2) * (mx - mn + 1) - total);
}
