include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <cleat.scad>

// Render options
$fa = 1;    // Facet per angle
$fs = 0.5;  // Facet size

$slop = 0.1;


brace_cleat_gap = cleat_height;
brace_width = 8;
brace_border = 16;

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
