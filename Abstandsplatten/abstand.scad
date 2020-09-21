$fn=24;

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
                sphere(d=2,$fn=16);
                //cube([2,2,2], center=true);
              }
            }
          }
      }
}
module smooth(){
    minkowski(){
        offset_in(){children();};
        sphere(d=2,$fn=16);
    }
        
    
}
  
  
w=60.5;
d=45;
h=24.5;//21;//24.7;//39.6-21.6;//23.9;//22.5-3.5;//22.5 peter 19 feedcode
h1=7;

wb=45;
wb1=41.5;
db=30.5;
db1=27;

hb=7;
hb1=4;

sx=16.4+5.7;
sy=8.3+5.7;
sd=5.7;


module minus(){
    translate([60.5/2-10,-3/2,0])cube([10,3,h1]);
    translate([19.2/2-3,d/2-10,0])cube([3,10,h1]);
    translate([0,-d/2,0])cube([10,10,50]);
}    
difference(){
smooth()
{
    difference(){
        translate([-w/2,-d/2,0.01])cube([w,d,h]);
        minus();
        mirror([1,0,0])minus();
        hull(){
            translate([-wb/2,-db/2,h])cube([wb,db,hb1]);
            translate([-wb1/2,-db1/2,h-hb1])cube([wb1,db1,hb1]);
        }
        translate([-wb1/2,-db1/2,h-hb])cube([wb1,db1,hb]);
        translate([-sx/2,0,0])cylinder(d=sd,h=50);
        translate([sx/2,0,0])cylinder(d=sd,h=50);
        translate([0,+sy/2,0])cylinder(d=sd,h=50);
        translate([0,-sy/2,0])cylinder(d=sd,h=50);
    }
}

translate([0,d/2-1,h-1+0.1])scale([0.6,0.6,1])rotate([0,0,180])linear_extrude(height = 1)text(str(h),halign="center");

}