celld=18;
d=1;
d2=5;
h=49;


module spacer(n,extra=0){
    difference(){
        translate([0,0,-extra])cube([n*20,h,4+extra]);
        for(i=[-2:n+1]){
            translate([20*i+10,0,10])rotate([-90,0,0])cylinder(d=celld,h=h);
        }
    }
}
//mirror([1,0,0])rotate([0,-90,0])spacer(4.5,2);

height=68;
depth=6;
wall = 3;

module bracket(n){
    difference(){
        translate([0,-wall,-wall])cube([n*20,wall+depth,height+2*wall]);
        translate([0,0,0])cube([n*20,wall+depth,height]);
    }
}

module goodprotector(n){
    difference(){
        union(){
            translate([0,-height/2,0])mirror([0,1,0])rotate([90,0,0])bracket(n);
            translate([0,-h/2,0])spacer(n);
        }
        for(i=[1:n-1]){
            translate([20*i,0,-10])holes();
        }
    }
}

module holes(){
    for(i=[-2:2]){
        translate([0,10*i,0])cylinder(d=4,h=100,$fn=24);
    }
}


//1:
if(true)goodprotector(9);

//2:
if(false)difference(){
    spacer(8);
    cube([4,100,30]);
    for(i=[0:8]){
        translate([20*i,h/2,-10])holes();
    }
}