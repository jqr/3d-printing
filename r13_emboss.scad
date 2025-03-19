stamp_depth = 2;
width=25;
height=95;
buffer=25;
buffered_width = width + buffer*2;
buffered_height = height + buffer*2;
backing = 5;
guide = backing;
guide_length = 10;
guide_depth = stamp_depth + 2;


translate([-buffered_width/2,-buffered_height/2,-backing]) cube([buffered_width, buffered_height, backing]);
linear_extrude(stamp_depth, scale=1.01) {
  rotate([0,180,0]) import("r13-invert.svg", center=true);
};


translate([-buffered_width/2 - guide, -buffered_height/2, -backing]) cube([guide, guide_length, guide_depth + backing]);
translate([-buffered_width/2 - guide, buffered_height/2 - guide_length + guide, -backing]) cube([guide, guide_length, guide_depth + backing]);

translate([-buffered_width/2 - guide, buffered_height/2, -backing]) cube([guide_length, guide, guide_depth + backing]);
translate([buffered_width/2 - guide_length , buffered_height/2, -backing]) cube([guide_length, guide, guide_depth + backing]);
