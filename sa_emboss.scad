// Render options
$fa = 1;    // Facet per angle
$fs = 0.5;  // Facet size

page_width = 145;

width=80;
height=86.6;

stamp_depth = 2;

backing_width = page_width;
padding=(page_width - width) / 2;
backing_height = height + padding*2;

backing = 5;
guide = backing;
guide_length = 20;
guide_depth = stamp_depth + 2;

difference() {
  union() {
    translate([-backing_width/2,-backing_height/2,-backing]) cube([backing_width, backing_height, backing]);
    linear_extrude(stamp_depth, scale=1.01) {
      rotate([0,180,0]) import("scale_assembly_clean.svg", center=true);
    };

    translate([-backing_width/2 - guide, -backing_height/2, -backing]) cube([guide, guide_length, guide_depth + backing]);
    translate([-backing_width/2 - guide, backing_height/2 - guide_length + guide, -backing]) cube([guide, guide_length, guide_depth + backing]);

    translate([-backing_width/2 - guide, backing_height/2, -backing]) cube([guide_length, guide, guide_depth + backing]);
    translate([backing_width/2 - guide_length , backing_height/2, -backing]) cube([guide_length, guide, guide_depth + backing]);
  }
  translate([50,-100,-30])  cube([50, 150, 100]);
  translate([-50,-100,-30]) cube([150, 50, 100]);
  translate([0,100,-30])  cylinder(h=50, r=50);
  translate([-100,0,-30]) cylinder(h=50, r=50);
}
