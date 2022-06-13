raggio = 2.5;
altezza_cilindro = 10;
pronfondita = 15;

module triangle(o_len, a_len, depth, center=false)
{
    centroid = center ? [-a_len / 3, -o_len / 3, -depth / 2] : [0, 0, 0];
    translate(centroid) linear_extrude(height=depth)
    {
        polygon(points=[[0, 0],[a_len, 0],[0, o_len]], paths=[[0, 1, 2]]);
    }
}

cylinder(r = raggio, h = altezza_cilindro, center = false, $fn = 50);
translate([2, 0, altezza_cilindro + 3]) rotate(a = 90, v = [1, 0, 0]) triangle(15, 20, 10, true);
