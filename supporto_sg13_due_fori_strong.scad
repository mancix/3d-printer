lunghezza_globale = 210;
larghezza_globale = 35;
spessore_globale = 10;

// blocco aggancio scrivania
lunghezza_blocco_scrivania = spessore_globale;
altezza_blocco_scrivania = 30 + spessore_globale;
larghezza_blocco_scrivania = larghezza_globale;
raggio_foro_blocco_scrivania = 3;
distanza_foro_blocco_scrivania = altezza_blocco_scrivania / 2 + 4;

// blocco principale
spessore_blocco_principale = spessore_globale;
larghezza_blocco_principale = larghezza_globale;
lunghezza_blocco_principale = lunghezza_globale - lunghezza_blocco_scrivania;

// sostegni
altezza_sostegno = altezza_blocco_scrivania - spessore_globale;
lunghezza_sostegno = (larghezza_globale > 20) ? lunghezza_blocco_principale : lunghezza_globale/2;
spessore_sostegno = 5;
distanza_sostegno_dal_piano = spessore_blocco_principale;
distanza_primo_sostegno = spessore_sostegno;
distanza_secondo_sostegno = larghezza_blocco_principale;

// blocco computer
altezza_blocco_computer = 45;
larghezza_blocco_computer = larghezza_globale;
spessore_blocco_computer = spessore_globale;
distanza_blocco_computer = lunghezza_blocco_principale - spessore_blocco_computer;
distanza_foro_blocco_computer = altezza_blocco_computer / 2 + 4;

/* MODULI */

module plate(length, width, thickness, hole_radius = 0, hole_distance = 0, number_of_holes = 1) {
    if (hole_radius == 0) {
        cube([length, width, thickness ]);
    } else {
    
        difference() {
        
            
            cube([length, width, thickness]);
            
            if (number_of_holes > 1) {
                distanza_due_fori = 8;
                
                translate([length/2, hole_distance + distanza_due_fori, 0]) {
                    cylinder(r = hole_radius, h = thickness, $fn = 30);
                }
                
                translate([length/2, hole_distance - distanza_due_fori, 0]) {
                    cylinder(r = hole_radius, h = thickness, $fn = 30);
                }
            } else {
                translate([length/2, hole_distance, 0]) {
                    cylinder(r = hole_radius, h = thickness, $fn = 30);
                }
            }

        }
    }
}

// base, altezza, profondità
module triangle(o_len, a_len, depth, center=false)
{
    centroid = center ? [-a_len / 3, -o_len / 3, -depth / 2] : [0, 0, 0];
    translate(centroid) linear_extrude(height=depth)
    {
        polygon(points=[[0, 0],[a_len, 0],[0, o_len]], paths=[[0, 1, 2]]);
    }
}

/* COMPOSIZIONE */

// blocco principale
color("Pink", 1.0) {
    plate(larghezza_blocco_principale, lunghezza_blocco_principale, spessore_blocco_principale);
}

color("Red", 1.0) { 
    rotate(a = 90, v = [1, 0, 0]) plate(larghezza_blocco_scrivania, altezza_blocco_scrivania, lunghezza_blocco_scrivania, raggio_foro_blocco_scrivania, distanza_foro_blocco_scrivania, 2);
}

color("Orange", 1.0) {
    // sostegno 1
    translate([distanza_primo_sostegno, 0, distanza_sostegno_dal_piano]) rotate(a = 270, v = [0, 1, 0]) triangle(lunghezza_sostegno, altezza_sostegno, spessore_sostegno);
    
    //sostegno 2
    translate([distanza_secondo_sostegno, 0, distanza_sostegno_dal_piano]) rotate(a = 270, v = [0, 1, 0]) triangle(lunghezza_sostegno, altezza_sostegno, spessore_sostegno);
}

color("Green", 1.0) {
    translate([0, distanza_blocco_computer, 0]) rotate(a = 270, v = [1, 0, 0]) plate(larghezza_blocco_computer, altezza_blocco_computer, spessore_blocco_computer, raggio_foro_blocco_scrivania, distanza_foro_blocco_computer, 2);
}
if (altezza_blocco_computer > 28) {
    color("Violet", 1.0) {
            translate([0, lunghezza_blocco_principale - spessore_blocco_computer, 0]) rotate(a = 270, v = [1, 0, 0]) { rotate(a = 90, v = [0, 1, 0]) triangle(12, 25, larghezza_globale);
    }
}
}