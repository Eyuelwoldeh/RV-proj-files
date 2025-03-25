// Raspberry Pi Car Motor Controller Mount
// For two 43mm x 43mm motor controllers

mc_width = 46;
mc_length = 46;
mc_hole_inset = 4.2;  
mc_hole_diameter = 4.7;

// Base plate dimensions
base_length = 105; // Enough for two controllers plus spacing
base_width = 50;
base_thickness = 9;

// column cylinders height from wall

clearance_columns = -2.5;

// Car mounting
car_mount_hole_distance = 54; // Distance between car mounting points
car_mount_hole_diameter = 3.4; // M2.5 with slight tolerance
car_mount_countersink_diameter = 14; // Diameter of countersink
car_mount_countersink_depth = 4; // Depth of countersink

// Additional parameters
spacing_between_controllers = 3; // Space between the two controllers
wall_height = 8; // Height of walls for stability
corner_radius = 3; // Rounded corners

module roundedRect(size, radius) {
    x = size[0];
    y = size[1];
    z = size[2];
    
    linear_extrude(height=z)
    hull() {
        // Place circles at the four corners
        translate([radius, radius, 0])
        circle(r=radius);
        
        translate([x-radius, radius, 0])
        circle(r=radius);
        
        translate([x-radius, y-radius, 0])
        circle(r=radius);
        
        translate([radius, y-radius, 0])
        circle(r=radius);
    }
}

// Motor controller mounting section - now centered
module motorControllerMount() {
    // Calculate total width needed for controllers
    total_controllers_width = 2 * mc_length + spacing_between_controllers;
    // Calculate offset to center controllers
    controller_x_offset = (base_length - total_controllers_width) / 2;
    
    difference() {
        union() {
            // Base plate with rounded corners
            // Center everything relative to origin
            translate([-base_length/2, -base_width/2, 0])
            roundedRect([base_length, base_width, base_thickness], corner_radius);
            
            // First controller platform - centered
            translate([-(total_controllers_width/2), -mc_width/2, base_thickness]) {
                // Platform
                cube([mc_length, mc_width, 1]);
                
                // Walls for stability
                cube([mc_length, 1, wall_height]);
                
                translate([0, mc_width-1, 0])
                cube([mc_length, 1, wall_height]);
                
                translate([0, 0, 0])
                cube([1, mc_width, wall_height]);
                
                translate([mc_length-1, 0, 0])
                cube([1, mc_width, wall_height]);
            }
            
            // Second controller platform - centered
            translate([spacing_between_controllers/2, -mc_width/2, base_thickness]) {
                // Platform
                cube([mc_length, mc_width, 1]);
                
                // Walls for stability
                cube([mc_length, 1, wall_height]);
                
                translate([0, mc_width-1, 0])
                cube([mc_length, 1, wall_height]);
                
                translate([0, 0, 0])
                cube([1, mc_width, wall_height]);
                
                translate([mc_length-1, 0, 0])
                cube([1, mc_width, wall_height]);
            }
            
            // First controllers standing columns
            
            translate([-(total_controllers_width/2) + mc_hole_inset, -mc_width/2 + mc_hole_inset, 0])
        cylinder(h=base_thickness+wall_height+clearance_columns, d=mc_hole_diameter, $fn=24);
            
            translate([-(total_controllers_width/2) + mc_length-mc_hole_inset, -mc_width/2 + mc_hole_inset, 0])
        cylinder(h=base_thickness+wall_height+clearance_columns, d=mc_hole_diameter, $fn=24);
        
        translate([-(total_controllers_width/2) + mc_hole_inset, mc_width/2 - mc_hole_inset, 0])
        cylinder(h=base_thickness+wall_height+clearance_columns, d=mc_hole_diameter, $fn=24);
        
        translate([-(total_controllers_width/2) + mc_length-mc_hole_inset, mc_width/2 - mc_hole_inset, 0])
        cylinder(h=base_thickness+wall_height+clearance_columns, d=mc_hole_diameter, $fn=24);
            
           // Second controllers standing columns
        
         translate([spacing_between_controllers/2 + mc_hole_inset, -mc_width/2 + mc_hole_inset, 0])
        cylinder(h=base_thickness+wall_height+clearance_columns, d=mc_hole_diameter, $fn=24);
        
        translate([spacing_between_controllers/2 + mc_length-mc_hole_inset, -mc_width/2 + mc_hole_inset, 0])
        cylinder(h=base_thickness+wall_height+clearance_columns, d=mc_hole_diameter, $fn=24);
        
        translate([spacing_between_controllers/2 + mc_hole_inset, mc_width/2 - mc_hole_inset, 0])
        cylinder(h=base_thickness+wall_height+clearance_columns, d=mc_hole_diameter, $fn=24);
        
        translate([spacing_between_controllers/2 + mc_length-mc_hole_inset, mc_width/2 - mc_hole_inset, 0])
        cylinder(h=base_thickness+wall_height+clearance_columns, d=mc_hole_diameter, $fn=24); 
           
        
}
        
        
        
        // Car mounting holes with countersinks using simple cylinders
        // First mounting hole - through hole
        translate([-car_mount_hole_distance/2, 0, -1])
        cylinder(h=base_thickness+wall_height, d=car_mount_hole_diameter, $fn=24);
        
        // First mounting hole - countersink on top surface
translate([-car_mount_hole_distance/2, 0, base_thickness-6])
cylinder(h=car_mount_countersink_depth, d1=car_mount_hole_diameter, d2=car_mount_countersink_diameter, $fn=40);
        
        // countersink for the pins coming out of the bottom of the controllers
        
        translate([base_length/4 - 1.7, 0, base_thickness])
        cube([32.5, 38, 6], center = true);
        
        // Second mounting hole - through hole
        translate([car_mount_hole_distance/2, 0, -1])
        cylinder(h=base_thickness+wall_height+10, d=car_mount_hole_diameter, $fn=24);
        
        // Second mounting hole - CORRECTED countersink on top surface
translate([car_mount_hole_distance/2, 0, base_thickness-6])
cylinder(h=car_mount_countersink_depth, d1=car_mount_hole_diameter, d2=car_mount_countersink_diameter, $fn=40);

        // countersink for the second mounting area
        
        translate([-base_length/4 + 1.7, 0, base_thickness])
        cube([32.5, 38, 6], center = true);
        
        // Add ventilation holes under the platform
// First side
translate([base_length/4 - 15, 0, -1])
cube([16, 32, base_thickness+30], center = true);

translate([base_length/4 + 13.5, 0, -1])
cube([12, 32, base_thickness+30], center = true);

// Second side

translate([-base_length/4 + 15, 0, -1])
cube([16, 32, base_thickness+30], center = true);

translate([-base_length/4 - 13.5, 0, -1])
cube([12, 32, base_thickness+30], center = true);




    }
}

//intersection() {
    motorControllerMount();
    //This creates a cutting plane that passes through both mounting holes
    //translate([-car_mount_hole_distance/2, -25, -1])
    //cube([car_mount_hole_distance, 50, 20]);
//}