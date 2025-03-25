include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <cleat.scad>

// Render options
$fa = 1;    // Facet per angle
$fs = 0.5;  // Facet size

$slop = 0.1;

cleat_depth = 8;
cleat_height = 16;
cleat_filet = 0.5;
cleat_spacing = (cleat_height + cleat_depth) * 2;
cleat_screw = "#10";
cleat_screw_sink = 0;
cleat_gap = 1;

brace_landing_offset = 0.49; // 0 = Forces on wall, 0.5 Forces on wall cleat
brace_cleat_gap = cleat_height;
brace_depth = 256;
brace_height_min = brace_depth/3;
brace_count = ceil((brace_height_min) / cleat_spacing);
brace_height = (brace_count + brace_landing_offset) * cleat_spacing + brace_cleat_gap;
brace_width = 8;
brace_border = 16;
brace_filet = 4;

brace_screw = "#8";
brace_screw_width = struct_val(screw_info(brace_screw, head="flat"), "head_size");
brace_screw_margin = brace_screw_width/2;
brace_screw_depth = 4;

brace_fin_depth = 2;
brace_fin_width = 4;

top_screw = brace_screw;
top_screw_head = brace_screw_width;

screwable_depth = brace_screw_depth;
screwable_width = top_screw_head * 3;

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

first_cleat_start = brace_border;
cleat_count = 5;
cleat_overlap_offset = 0;
color("#ccc")
rotate([-90,0,0])
up(cleat_depth) {
  difference() {
    union() {
      right(first_cleat_start) xcopies(n=cleat_count, spacing=cleat_spacing, sp=CENTER) {
        cleat(brace_width + get_slop() * 2);
      };
      difference() {
        union() {
          zcopies(n=2, spacing=brace_width + cleat_depth + get_slop() * 2, sp=CENTER)
            left(cleat_depth) cube([cleat_spacing*cleat_count + cleat_depth, cleat_depth, cleat_depth], anchor=TOP + FRONT + LEFT);
        }

        fwd(1) left(1) back(cleat_overlap_offset) {
          // Top overlap
          left(cleat_depth) cube([cleat_depth*2, cleat_depth*2, cleat_depth * 5], anchor=FRONT + LEFT, spin=[0,0,45]);
          right(2) left(cleat_depth) cube([cleat_depth*2, cleat_depth*2, cleat_depth * 6], anchor=FRONT + RIGHT, spin=[0,0,0]);

          // Bottom overlap
          difference() {
            left(cleat_depth) right(cleat_spacing*cleat_count) cube([cleat_depth*2, cleat_depth*2, cleat_depth * 5], anchor=BACK + LEFT, spin=[0,0,45]);
            right(2) left(cleat_depth) right(cleat_spacing*cleat_count) cube([cleat_depth*2, cleat_depth*2, cleat_depth * 6], anchor=FRONT + RIGHT, spin=[0,0,0]);
          }
        }
      }
    }
    right(first_cleat_start) xcopies(n=cleat_count, spacing=cleat_spacing, sp=CENTER)
      up(brace_width/2) right(brace_cleat_gap) fwd(cleat_screw_sink + 1) screw_hole(cleat_screw, length=cleat_depth + 1, head="flat", anchor=BOTTOM, orient=BACK);
  }
};

module brace_outer_poly() {
  polygon(
    points=[
      [           0,            0],
      [           0,  brace_depth],
      [brace_border,  brace_depth],
      [brace_height, brace_border],
      [brace_height,            0],
    ],
  );
}


tab_size = brace_screw_width + brace_screw_margin * 2;

max_brace_width = brace_width + tab_size - brace_screw_margin;
bore = 10;
first_screw_offset = cleat_depth + brace_screw_margin + brace_screw_width;
back(60) {
  difference() {
    linear_extrude(max_brace_width) difference() {
      round2d(brace_filet)                       brace_outer_poly();
      round2d(brace_filet) offset(-brace_border) brace_outer_poly();
    }
    down(1) right(cleat_height) xcopies(n=5, spacing=cleat_spacing, sp=CENTER) cleat_mask(max_brace_width + 2);
    up(brace_width) fwd(1) cube([brace_height, brace_width + 1, max_brace_width]);
    up(brace_width + brace_fin_width) right(brace_screw_depth) back(brace_width-1) cube([brace_height, brace_width, max_brace_width]);
    up(brace_width) right(brace_screw_depth) back(brace_fin_depth + cleat_depth) cuboid([brace_height, brace_depth + brace_filet * 2, max_brace_width], rounding=brace_filet, anchor=BOTTOM+LEFT+FRONT);
    right(screwable_depth + bore) up(brace_width) back(first_screw_offset) ycopies(n=2, l=brace_depth - first_screw_offset - tab_size/2, sp=CENTER) screw_hole(brace_screw, length=cleat_depth + 1, head="flat", counterbore=bore, anchor=TOP+RIGHT, orient=RIGHT);
    up(brace_width) right(brace_screw_depth) back(first_screw_offset + tab_size/2) cuboid([brace_height, brace_depth - first_screw_offset - tab_size*1.5, max_brace_width], rounding=brace_filet, anchor=BOTTOM+FRONT);
  }

}
