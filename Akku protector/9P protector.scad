celld=18;
d=1;
d2=5;
h=49;

n=5;

difference(){
   translate([-7,0,0])cube([n*20+14,h,3]);
    for(i=[-2:n+1]){
        translate([20*i+10,0,10])rotate([-90,0,0])cylinder(d=celld,h=h);
    }
}