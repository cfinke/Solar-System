/**
 * All measurements are in kilometers.
 */
 
scale = .01;
planet_scale = 20;
distance_scale = .021;

earth_days_per_animation = 900;

sun_radius = 696300;

$fa = 5;

module sun() {
    rotate([7.25, 0, 0])
    rotate([0, 0, $t * (24 / (58.7 * 24)) * 360 * earth_days_per_animation])
        color("yellow")
        sphere(r=sun_radius * scale);
}

module mercury() {
    rotate([2, 0, 0])
        rotate([0, 0, -$t * (24 / (243 * 24)) * 360 * earth_days_per_animation])
        color("darkgray")
        planet(r=2440);
}

module venus() {
    rotate([0, 0, -$t * (24 / (58.7 * 24)) * 360 * earth_days_per_animation])
        color("lightyellow")
        planet(r=6052);
}

module earth() {
    planet_rotation = -$t * (24 / 24) * 360 * earth_days_per_animation;
    
    rotate([23.5, 0, 0])
    rotate([0, 0, planet_rotation])
    union() {
        color("blue") planet(r=6371);

        // Moon
        satellite(radius=1737, orbital_radius=380000, orbital_period=28, planet_rotation=planet_rotation, rotational_period=28, angle=6.68, planet_radius=6371);
    }
}

module mars() {
    planet_rotation = -$t * (24 / 24.6) * 360 * earth_days_per_animation;
    rotate([25, 0, 0])
        rotate([0, 0, planet_rotation]) union() {
        color("red")
            planet(r=3390);
       
    }
}

module jupiter() {
    planet_rotation = -$t * (24 / 9.84) * 360 * earth_days_per_animation;
    rotate([3, 0, 0])
    rotate([0, 0, planet_rotation])
    union() {
         color("tan") planet(r=69911);
        /*
        // Thebe gossamer ring
        ring(r=226000 * scale, w=97000 * scale, h=8400 * scale);
        
        // Amalthea gossamer ring
        ring(r=182000 * scale, w=53000 * scale, h=2000 * scale);
        
        // Main ring
        ring(r=129000 * scale, w=6500 * scale, h=300 * scale);
        
        // Halo ring
        ring(r=122500 * scale, w=30500  * scale, h=12500 * scale);
        */
        // Ganymede
        color("gray") satellite(radius=2631, orbital_radius=69911 + 1070000, orbital_period=7.154553, planet_rotation=planet_rotation, rotational_period=7.154553, planet_radius=69911);
            
        // Callisto
        color("gray") satellite(radius=2400, orbital_radius=69911 + 1883000, orbital_period=16.68902, planet_rotation=planet_rotation, rotational_period=16.68902, planet_radius=69911);
            
        // Io
        color("yellow") satellite(radius=1815, orbital_radius=69911 + 421600, orbital_period=1.769138, planet_rotation=planet_rotation, rotational_period=1.769138, planet_radius=69911);
        
        // Europa
        color("tan") satellite(radius=1569, orbital_radius=69911 + 670900, orbital_period=3.551181, planet_rotation=planet_rotation, rotational_period=3.551181, planet_radius=69911);
    }
}

module saturn() {
    planet_rotation = $t * (24 / 10.2) * 360 * earth_days_per_animation;
    
    rotate([26, 0, 0])
    rotate([0, 0, planet_rotation])
    union() {
       color("goldenrod") planet(r=60300);
       color("sienna") ring(r=141000, w=74000, h=1);
        
        // Mimas
        color("gray") satellite(radius=198, orbital_radius=185539, orbital_period=0.9, planet_rotation=planet_rotation, rotational_period=0, planet_radius=60300);
        
        // Enceladus
        color("gray") satellite(radius=277, orbital_radius=237948, orbital_period=1.4, planet_rotation=planet_rotation, rotational_period=0, planet_radius=60300);
        
        // Tethys
        color("gray") satellite(radius=1062/2, orbital_radius=294619, orbital_period=1.9, planet_rotation=planet_rotation, rotational_period=0, planet_radius=60300);
        
        // Dione
        color("gray") satellite(radius=1123/2, orbital_radius=377396, orbital_period=2.7, planet_rotation=planet_rotation, rotational_period=0, planet_radius=60300);
        
        // Rhea
        color("gray") satellite(radius=1527/2, orbital_radius=527108, orbital_period=4.5, planet_rotation=planet_rotation, rotational_period=0, planet_radius=60300);
        
        // Titan
        color("gray") satellite(radius=5150/2, orbital_radius=1221870, orbital_period=16, planet_rotation=planet_rotation, rotational_period=0, planet_radius=60300);
        
        // Iapetus
        color("gray") satellite(radius=1470/2, orbital_radius=3560820, orbital_period=79, planet_rotation=planet_rotation, rotational_period=0, planet_radius=60300);

    }
}

module uranus() {
    rotate([97, 0, 0]) rotate([0, 0, -$t * (24 / 17.9) * 360 * earth_days_per_animation])
    color( "powderblue") planet(r=25362);
}

module neptune() {
    rotate([29.6, 0, 0]) rotate([0, 0, -$t * (24 / 19.1) * 360 * earth_days_per_animation]) color("skyblue") planet(r=24622);
}

module pluto() {
    planet_rotation = -$t * (24 / (6.39 * 24)) * 360 * earth_days_per_animation;
    
    rotate([122.5, 0, 0]) rotate([0, 0, planet_rotation]) color( "saddlebrown") planet(r=1186);
    
    // Charon
        color("gray") satellite(radius=1208/2, orbital_radius=606, orbital_period=6.387230, planet_rotation=planet_rotation, rotational_period=0, planet_radius=1186);
}

module ring(r, w, h) {
    translate([0, 0, h * scale / 2]) linear_extrude(h=h * scale) difference() {
        circle(r=r * scale);
        circle(r=(r-w) * scale);
    }
}

module planet(r) {
    sphere(r=r * scale);
}

module satellite(radius, orbital_radius, orbital_period, planet_rotation, rotational_period, angle=0, planet_radius=0) {
    rotate([0, 0, -planet_rotation + (-$t * (24 / (24 * orbital_period)) * 360 * earth_days_per_animation)])
        translate([0, (planet_radius * scale ) + (orbital_radius * distance_scale * scale), 0])
        rotate([0, 0, -$t * (24 / (rotational_period * 24)) * 360 * earth_days_per_animation]) 
        rotate([angle, 0, 0])
        sphere(r=radius * scale);
}

sun();

rotate([3.38, 0, 5])
    rotate([0, 0, $t * (earth_days_per_animation / 87.96) * 360])
    translate([(sun_radius * scale) + (57900000 * scale * distance_scale), 0, 0])
    scale([planet_scale, planet_scale, planet_scale])
    mercury();

rotate([3.86, 0, 5])
    rotate([0, 0, $t * (earth_days_per_animation / 224.68) * 360])
    translate([(sun_radius * scale) + (108200000 * scale * distance_scale), 0, 0])
    scale([planet_scale, planet_scale, planet_scale])
    venus();

rotate([7.155, 0, 250])
    rotate([0, 0, $t * 360 * (earth_days_per_animation / 365.25)])
    translate([(sun_radius * scale) + (149600000 * scale * distance_scale), 0, 0])
    scale([planet_scale, planet_scale, planet_scale])
    earth();

rotate([5.65, 0, 280])
    rotate([0, 0, $t * (earth_days_per_animation / 686.98) * 360])
    translate([(sun_radius * scale) + (227900000 * scale * distance_scale), 0, 0])
    scale([planet_scale, planet_scale, planet_scale])
    mars();
    
rotate([6.09, 0, 260])
    rotate([0, 0, $t * (earth_days_per_animation / (11.862 * 365.25)) * 360])
    translate([(sun_radius * scale) + (778300000 * scale * distance_scale), 0, 0])
    scale([planet_scale, planet_scale, planet_scale])
    jupiter();
    
rotate([5.51, 0, 340])
    rotate([0, 0, $t * (earth_days_per_animation / (29.456 * 365.25)) * 360])
    translate([(sun_radius * scale) + (1427000000 * scale * distance_scale), 0, 0])
    scale([planet_scale, planet_scale, planet_scale])
    saturn();
    
rotate([6.48, 0, 100])
    rotate([0, 0, $t * (earth_days_per_animation / (84.07 * 365.25)) * 360])
    translate([(sun_radius * scale) + (2871000000 * scale * distance_scale), 0, 0])
    scale([planet_scale, planet_scale, planet_scale])
    uranus();
    
rotate([6.43, 0, 70])
    rotate([0, 0, $t * (earth_days_per_animation / (164.81 * 365.25)) * 360])
    translate([(sun_radius * scale) + (4497100000 * scale * distance_scale), 0, 0])
    scale([planet_scale, planet_scale, planet_scale])
    neptune();
    
rotate([11.88, 0, 10])
    rotate([0, 0, $t * (earth_days_per_animation / (247.7 * 365.25)) * 360])
    translate([(sun_radius * scale) + (5913000000 * scale * distance_scale), 0, 0])
    scale([planet_scale, planet_scale, planet_scale])
    pluto();