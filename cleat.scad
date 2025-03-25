include <BOSL2/std.scad>
include <BOSL2/screws.scad>

$slop = 0.1;

cleat_depth = 8;
cleat_height = 16;
cleat_filet = 0.5;
cleat_spacing = (cleat_height + cleat_depth) * 2;
cleat_screw = "#10";
cleat_screw_sink = 0;
cleat_gap = 1;

module cleat_poly(h=cleat_height, d=cleat_depth, round=cleat_filet, extended_depth=0, flat_bottom=false, gap=false) {
  // TODO: slop
  gap = gap ? gap: 0;
  e = extended_depth + round*2;
  d2 = flat_bottom ? d - e: d * 2;
  difference() {
    round2d(round) polygon(
      points=[
        [ d      + e       ,   - e],
        [                 0, d    ],
        [ d                , d    ],
        [ d  + h      - gap, d    ],
        [ d2 + h  + e - gap,   - e],
      ],
    );
    left(1) fwd(extended_depth) square([cleat_height + cleat_depth * 2 + 2 + e, e + 1], anchor=BACK + LEFT);
  }
}
module cleat(w=1) {
  linear_extrude(w) cleat_poly(flat_bottom=false, gap=cleat_gap);
}

module cleat_mask(w=1) {
  linear_extrude(w) cleat_poly(d=cleat_depth, extended_depth=1, flat_bottom=false);
}
