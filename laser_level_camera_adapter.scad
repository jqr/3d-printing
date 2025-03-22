// Render options
$fa = 1;    // Facet per angle
$fs = 0.5;  // Facet size

magnet_diameter = 10;
magnet_diameter_with_buffer = magnet_diameter + 0.1;
magnet_depth = 3;

laser_magnet_spread = 25;
laser_backing_height=91;
laser_backing_width=32;

mount_laser_depth = 5;

camera_stable_grip_height = 65;
camera_grip_width = 25;
camera_grip_depth = 12;
camera_grip_overhang = 23; // add safety to this
camera_grip_overhang_with_buffer = camera_grip_overhang + 4;
camera_grip_overhang_width = 39;

module magnet_hole() {
  cylinder(r=magnet_diameter_with_buffer/2, h=magnet_depth);
  // cylinder(r=magnet_diameter_with_buffer/3, h=magnet_depth+1);
}

module laser_mount() {
  difference() {
    translate([-laser_backing_height/2,-laser_backing_width/2,0]) cube([laser_backing_height, laser_backing_width, mount_laser_depth]);

    translate([-laser_magnet_spread/2,0,0]) {
      magnet_hole();
      translate([laser_magnet_spread,0,0]) magnet_hole();
    }
  }
}


module camera_grip() {
  connection_ratio = 0.8;
  connection_width = laser_backing_width;
  connection_height = camera_stable_grip_height * connection_ratio;
  connection_depth = camera_grip_overhang_with_buffer - camera_grip_depth;
  translate([0,0,connection_depth]) {
    difference() {
      union() {
        translate([0,0,camera_grip_depth/2]) cube([camera_stable_grip_height,camera_grip_overhang_width,camera_grip_depth], center=true);
        translate([0,0,-camera_grip_overhang_with_buffer/2 + camera_grip_depth]) cube([connection_height,connection_width,camera_grip_overhang_with_buffer], center=true);
      }
      translate([0,0,-50]) cylinder(r=laser_backing_width/3, h=100);
    }
  }
}


rotate([180]) {
translate([0,50,mount_laser_depth]) laser_mount();

camera_grip();
}
