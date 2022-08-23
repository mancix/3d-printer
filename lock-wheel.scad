difference() {
    rotate(a=270, v=[0, 0, 1]) {
        cube([74, 24, 20 ]);
    }

    color("Pink", 1.0) {
        translate([2, -38, 37]) {
            rotate(a=90, v=[0,1,0]) {
                cylinder(r = 35, h = 20, $fn = 120);
            }
        }
    }
}