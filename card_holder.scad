include <BOSL2/std.scad>

// Render options
$fa = 1;    // Facet per angle
$fs = 0.5;  // Facet size

// Storage box for a set of cards:
width = 62.3;
length = 88;
height = 17;
filet = 3;

card_clearance = 1;
wall_thickness = 1.5;
wall_clearance = 0.75;

part_spacing = 10;

cutout_radius = height * 1.1;

// Inner Shell
translate([wall_thickness*2 + card_clearance + wall_clearance, wall_thickness*2 + card_clearance + wall_clearance,0]) {
    translate([0, 0, wall_thickness]) {
        difference() {
            linear_extrude(height + card_clearance*2) {
                // filet last to keep contact on edges and not corner
                shell2d(wall_thickness) round2d(filet) offset(card_clearance) square([width, length]);
            }
            translate([-width,length/2, height + card_clearance * 2]) rotate([90,0,90]) cylinder(h=width*3, r=cutout_radius);
        }
    }

    // Bottom Shell
    linear_extrude(wall_thickness) {
        offset(wall_thickness * 2 + wall_clearance) round2d(filet) offset(wall_clearance) square([width, length]);
    }
}

ggg = [wall_thickness*2 + wall_clearance*2 + (width+wall_thickness*4+card_clearance*2+wall_clearance*2 + part_spacing),0,0];

//Outer Shell
translate(ggg) {
    translate([0,wall_thickness*2+card_clearance+wall_clearance,0]) {
        translate([0, 0, wall_thickness]) {
            difference() {
                linear_extrude(height + card_clearance*2) {
                    // filet last to keep contact on edges and not corner
                    shell2d(wall_thickness) offset(wall_thickness + wall_clearance) round2d(filet) offset(card_clearance) square([width, length]);
                }
                translate([width/2,length*2,height + card_clearance * 2]) rotate([90,0,0]) cylinder(h=length*3, r=cutout_radius);
            }
        }

        // Bottom Shell
        linear_extrude(wall_thickness) {
            offset(wall_thickness*2 + wall_clearance) round2d(filet) offset(card_clearance) square([width, length]);
        }
    }
}
