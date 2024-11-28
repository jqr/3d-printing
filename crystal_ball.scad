$fa = 1;    // Facet per angle
$fs = 0.5;  // Facet size

// 99mm od

// natural sit
//   63mm height to bottom of sphere


// light
//   95mm od
//   76mm h (ttoal)
//   55mm to max lip

//   some buttons

//   10 sided 36º
//   buttons on one face
//   wire on next face

//   3mm wire
//   wire stick out
//     25mm distance
//     27mm height
//     6mm x 11mm x 28mm connector


//     feet of light
//       87mm od
//       70mm id

// total thing twice as tall as interior bit



inner_height = 5;
base_od = 85;

difference() {
  rotate_extrude(convexity = 10)
    // translate([10, 0, 0])
    rotate([0,0,0])
    polygon( points=[
        [51,   63],
        [51+5, 63+3],
        [base_od, -inner_height],
        [70/2, -inner_height],
        [70/2,   0],
        [51,   0],

      ]
    );
  translate([0,0,30]) rotate([-90,0,0]) cylinder(h=100, r=15/2);
}






%light();
// %translate([0,0,50]) bulb();

module light() {

  light_od = 95;
  light_height = 55;
  cylinder(h=light_height, r=light_od/2, $fn=10);

  connector_length = 28;
  connector_height = 6;
  connector_width = 11;
  connector_out = 25;
  translate([0, light_od/2 + connector_out, 27]) translate([-connector_width/2, -connector_length, 0]) cube([connector_width, connector_length, connector_height]);

  // WARNINIG: Not measured.
  translate([0,0,50]) sphere(r=25);
}

module bulb() {
  cylinder(h=13, r=99/2);
  translate([0,0, 100]) {
    difference() {
      sphere(r=200/2);
      translate([-50, -50, -100]) cube([200, 200, 10]);
    }
  }
}
