$fa = 1;    // Facet ped angle
$fs = 0.5;  // Facet size


object_h=10;
object_d=27.9;

wall_thickness = 3;
bottom_thickness = 5;

fudge = 0.01;

difference() {
  translate([0,0,-bottom_thickness]) cylinder(d=object_d + wall_thickness*2, h=object_h + bottom_thickness);
  translate([0,0,fudge]) cylinder(d=object_d, h=object_h);
  translate([0,0,-bottom_thickness - fudge]) cylinder(object_h+bottom_thickness + fudge*2, object_d/16, object_d/2 + wall_thickness/2);
}
