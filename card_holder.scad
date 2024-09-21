include <BOSL2/std.scad>

// 60mm x 93mm box inner

// 62.3mm x 88mm x 17mm card
// 3mm filet


// walls (0.8mm) a little flimsy
// tolerances a bit tight have to be lined up just right

// top/bottom textures suck (new plate on order)
// top/bottom edges too sharp (round)

// finger ports on outside are good (do some on onside too)

// Render options
$fa = 1;    // Facet per angle
$fs = 0.5;  // Facet size

// Object details
width=62.5;
depth=88;
height=17;
filet=3;

// Options
room=0.0; // Per side
thickness=1.5;
cutout_radius = height * 1.1;
shell_room = 0.75;
part_spacing = 10;


// Inner Shell
translate([thickness*2 + room + shell_room,thickness*2 + room + shell_room,0]) {
    translate([0, 0, thickness]) {
        difference() {
            linear_extrude(height + room*2) {
                // filet last to keep contact on edges and not corner
                shell2d(thickness) round2d(filet) offset(room) square([width, depth]);
            }
            translate([-width,depth/2, height + room * 2]) rotate([90,0,90]) cylinder(h=width*3, r=cutout_radius);
        }
    }

    // Bottom Shell
    linear_extrude(thickness) {
        offset(thickness * 2 + shell_room) round2d(filet) offset(room) square([width, depth]);
    }
}

ggg = [thickness*2 + shell_room*2 + (width+thickness*4+room*2+shell_room*2 + part_spacing),0,0];

//Outer Shell
translate(ggg) {
    translate([0,thickness*2+room+shell_room,0]) {
        translate([0, 0, thickness]) {
            difference() {
                linear_extrude(height + room*2) {
                    // filet last to keep contact on edges and not corner
                    shell2d(thickness) offset(thickness + shell_room) round2d(filet) offset(room) square([width, depth]);
                }
                translate([width/2,depth*2,height + room * 2]) rotate([90,0,0]) cylinder(h=depth*3, r=cutout_radius);
            }
        }

        // Bottom Shell
        linear_extrude(thickness) {
            offset(thickness*2 + shell_room) round2d(filet) offset(room) square([width, depth]);
        }
    }
}
