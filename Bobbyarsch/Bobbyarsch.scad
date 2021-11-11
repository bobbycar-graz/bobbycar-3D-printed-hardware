// The spacing between the two aluminium profiles in mm
MM_BETWEEN_ALUPROFILES = 110;

// Bobbyass™ thickness
MM_THICKNESS = 10;

// The height of the hole
MM_HEIGHT = 78;
// The width of the hole
MM_WIDTH = 140;

// The width of the left alu profile
MM_LEFT_ALU = 20;
// Probably same as left profile
MM_RIGHT_ALU = 20;
// Height of the alu profiles
MM_HEIGHT_ALU = 10;

// How many mm deep the 3d print should go between the alu profiles
MM_DEPTH_BACK = 25; 
// How many mm "deep" the 3d print should go at the top so you can drill a hole and lock it in place
MM_DEPTH_FRONT = 20;
// How high the two things above should be in mm
MM_DEPTH_HEIGHT = 8;

// Spaxgurt™ height
MM_BELT_HEIGHT = 20;

// Circle Radius
CIRCLE_RADIUS = 220; // [50:1:1000]

// Just for visual
GLOBAL_MM_ALU_LENGTH = 200;
// Global clearance between parts
GLOBAL_CLEARANCE = 1; // [0:0.1:5]

// Enable Smoothening
GLOBAL_EN_SMOOTH = false;
GLOBAL_SMOOTH = 2; // [1:2:5]
GLOBAL_SMOOTHNESS = 16; // [2:1:48]

// Toggle better visualization
BETTER_VISUALIZE = true;
// Color of the 3d print
3DPRINT_COLOR = [1,1,1]; //[0:0.1:1]

COLOR_1 = true;
COLOR_2 = false;

// Smooth
module smoother(){
    sphere(r=GLOBAL_SMOOTH,$fn=GLOBAL_SMOOTHNESS);
}
module offset_in() {
    difference() {
        //children();
        difference() {
          cube([1000, 1000, 1000], true);
            render() {   
              minkowski() {
                difference() {
                  cube([1000, 1000, 1000], true);
                  children();
                }                                        
                smoother();
              }
            }
          }
      }
}
module smooth(){
    minkowski(){
        offset_in(){children();};
        smoother();
    }
}


module alu(width, height) {
    cube([width, GLOBAL_MM_ALU_LENGTH, height]);
}

module alu_profiles(mm_left, mm_right, mm_height) {
    color("silver") {
        between = mm_left + MM_BETWEEN_ALUPROFILES;
        
        alu(mm_left, mm_height);
        
        translate([between,0,0]) {
            alu(mm_right, mm_height);
        }
    }
}

module top_bobbycar() {
    {
        translate([-20,-35,MM_HEIGHT]) {
            cube([MM_LEFT_ALU+MM_RIGHT_ALU+MM_BETWEEN_ALUPROFILES+GLOBAL_CLEARANCE*2 + 40,70,10]);
        }
    }
}

module show_visual() {
    alu_profiles(MM_LEFT_ALU, MM_RIGHT_ALU, MM_HEIGHT_ALU);
    top_bobbycar();
}

if (BETTER_VISUALIZE) {
    show_visual();
}

module between_alu() {
    translate([MM_LEFT_ALU + GLOBAL_CLEARANCE,0,0]) {
        cube([MM_BETWEEN_ALUPROFILES - 2*GLOBAL_CLEARANCE, MM_DEPTH_BACK, MM_HEIGHT_ALU - GLOBAL_CLEARANCE]);
    }
}

module belt(height, depth, width) {
    translate([0,-1,0]) {
        cube([width,depth+2,height]);
    }
}

module vertical_plate() {
        center = (MM_BETWEEN_ALUPROFILES / 2 + MM_LEFT_ALU);
        width = MM_WIDTH - GLOBAL_CLEARANCE * 2;
        height = MM_HEIGHT - GLOBAL_CLEARANCE;
        offset = center - width / 2;
    
        difference() {
            translate([offset,-MM_THICKNESS,0]) {
                cube([width, MM_THICKNESS, height]);
            }
            
            translate([offset, -MM_THICKNESS, height / 2 - MM_BELT_HEIGHT / 2 + (MM_HEIGHT_ALU - GLOBAL_CLEARANCE) / 2]) {
                belt_width = 1;
                translate([-0.05, 0,0]) {
                    belt(MM_BELT_HEIGHT, MM_THICKNESS, belt_width);
                }
                translate([width-belt_width+0.05,0,0]) {
                    belt(MM_BELT_HEIGHT, MM_THICKNESS, belt_width);
                }
            }
        }
}

module screw_plate() {
    
    center = (MM_BETWEEN_ALUPROFILES / 2 + MM_LEFT_ALU);
    width = MM_WIDTH - GLOBAL_CLEARANCE * 2;
    offset = center - width / 2;
    
    translate([offset,-MM_THICKNESS - MM_DEPTH_FRONT,MM_HEIGHT - GLOBAL_CLEARANCE - MM_DEPTH_HEIGHT]) {
        if (CIRCLE_RADIUS < 1000)
        {
            intersection() {
                translate([width/2, CIRCLE_RADIUS, 0]) {
                    cylinder(h=MM_DEPTH_HEIGHT, r=CIRCLE_RADIUS, $fs=5, $fa=5, $fn = 1000);
                }
                cube([width,MM_DEPTH_FRONT,MM_DEPTH_HEIGHT]);
            }
        }
        else
        {
            cube([width,MM_DEPTH_FRONT,MM_DEPTH_HEIGHT]);
        }
    }
}

module printable_inner(){
    union(){
        between_alu();
        vertical_plate();
        screw_plate();
    }
}
module printable() {
    if(COLOR_2 && !COLOR_1){
        intersection(){
            printable_inner();
            logo();
        }
    }
    else{
        difference(){
            printable_inner();
            if(COLOR_1 != COLOR_2){
                logo();
            }
        }
    }
    
}

// Now render the thing
color(3DPRINT_COLOR) {
    if (GLOBAL_EN_SMOOTH) {
        smooth() printable();
    } else {
        printable();
    }
}
module logo(){
    translate([(MM_LEFT_ALU + MM_RIGHT_ALU + MM_BETWEEN_ALUPROFILES)/2,0,15])
    rotate([90,0,0])
    scale([0.2,0.2,1])linear_extrude(100)import("bobby car.svg",center=true);
}