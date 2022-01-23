h = 29;
do = 54;
du = 41;

dd=53;


$fn = 96;

front=8;


module aussen(){
    intersection(){
        cylinder(d1=du, d2=do, h=h);
        rotate([0,0,30+180])cylinder(d=51*2, h=h,$fn=3);
        translate([-100,-100,0])cube([200,100+51/2,200]);

    }
}

module front(){
    render()intersection(){
        difference(){
            cylinder(d1=du, d2=do, h=h);
            cylinder(d1=du-5, d2=do-5, h=h);
            translate([0,0,20])cylinder(d=100,h=100);
        }
        translate([-front/2,0,0])cube([front,100,100]);
    }
}
module ccube(c){
    translate([-c.x/2,-c.y/2,0])
        cube(c);
}

module xt60() {
    w=16.46+0.2;
    d=9.13+0.02;
    h=15.7;
    
    
    
    wi=12;
    di=6;
    
    rotate([0,0,90])translate([0,0,-h+0.01]){
        ccube([w,d,h]);
        translate([0,0,-50+0.01])ccube([wi,di,50]);
    }
}

module xt90() {
    w=21.46+0.2;
    d=10.79+0.02;
    h=21.4;
    
    
    
    wi=17;
    di=7;
    
    translate([0,0,-h+0.01]){
        ccube([w,d,h]);
        translate([0,0,-50+0.01])ccube([wi,di,50]);
    }
}

module stecker(){
    xdiff=5.5;
    ydiff=13;
    translate([0,-13,h])xt90();
    translate([0,xdiff,h])xt60();
    translate([-ydiff,xdiff,h])xt60();
    translate([ydiff,xdiff,h])xt60();
}

module smoother(){
    sphere(r=0.5,$fn=16);
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



smooth()difference(){
    aussen();
    front();
    rotate([0,0,180])stecker();
    
}