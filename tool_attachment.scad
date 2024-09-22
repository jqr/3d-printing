$fa = 1;    // Facet per angle
$fs = 0.5;  // Facet size

// Tool wrap attachment area is 59.5mm diameter by 16mm deep
// Tools are ID 16-16.9mm, OD 19.8m by 122mm deep
// power tool to tool mount is 8.5mm deep and power tool is female with tool fitting inside

squeeze = 3;
thickness = 2.5;

fudge = 0.01;

inner_radius = (59.5 - squeeze)/2;

difference() {
  cylinder(h=16 + thickness, r=inner_radius + thickness);

  // Holding portion
  translate([0,0,thickness]) cylinder(h=16+1, r=inner_radius);

  // End stopper
  translate([0,0,-fudge]) cylinder(thickness + 2*fudge, inner_radius - thickness, inner_radius);

  // Slice
  translate([-squeeze,0,-1]) cube([squeeze*2,50,30]);
}

module holder(h, sir, lir, gap, thickness, chamfer_height=1) {
  difference() {
    cylinder(h=h, r=lir + thickness);

    // Entrance chamfer
    translate([0,0,h-chamfer_height]) cylinder(chamfer_height + fudge, sir, lir);

    // Holding portion
    translate([0,0,thickness]) cylinder(h=h-chamfer_height, r=sir);

    // End stopper
    translate([0,0,-fudge]) cylinder(h=h-chamfer_height + fudge, r=sir - thickness);

    // Slice
    if (gap > 0) rotate(180) translate([-gap,0,-1]) cube([gap*2,50,30]);
  }
}

holder_squeeze = .6;
growth = 2;
hir = (19.8 - holder_squeeze) / 2;

spread = 38;
for(i=[-2:2]) {
  rotate(spread * i) translate([0,-41.6,0]) holder(h=16, sir=hir, lir=hir + growth/2, gap=2, thickness = 1.5, chamfer_height=2.5);
}


// TODO:
// X holders 1mm smaller ID
// X holders 2x as deep on smaller diameter portion
// X Add bevel (5.5mm?) back onto rear holder
// X Stiffen rear holder?
// Front holder
//   front holder at 110mm from rearmost portion
//   chamfer starts 8.7mm from rear
//   58mm D (large)
///  54.5mm D (small)
// X holders too strong!
