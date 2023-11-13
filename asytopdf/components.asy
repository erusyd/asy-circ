import ElectricalComponents;
import Circuit;
import math;
real size=300;
size(size);

pair decal=(0,10);
pair A=(0,0), B=(50,0);
join(A,B,Multi(s="V"),Multi(s="A"));
join(A+decal,B+decal,Resistor(),Zresistor());
join(A+2decal,B+2decal,Capacitor());
join(A+3decal,B+3decal,Coil());
join(A+4decal,B+4decal,Battery(size=1.8,sign=true),
	Battery(type=1,sign=true,size=1.8));
join(A+5decal,B+5decal,IdealGen());
join(A+6decal,B+6decal,Icc());
join(A+7decal,B+7decal,Diode(size=2));
join(A+8decal,B+8decal,Zener(size=2));
join(A+9decal,B+9decal,Motor());
join(A+10decal,B+10decal,Lamp(fillpen=yellow),Lamp());
join(A+11decal,B+11decal,Switch());
join(A+12decal,B+12decal,Potentiometer());
join(A+13decal,B+13decal,PNP(),NPN());
join(A+14decal,B+14decal,OA(size=.5),AO(size=.5));
join(A+15decal,B+15decal,Tswitch(size=1.5));
join(A+16decal,B+16decal,Tension());
join(A+17decal,B+17decal,Intensity(size=2,fillpen=red));
join(A+18decal,B+18decal,Ground(size=1.5),
     Ground(size=1.5,type=1));
Element r=Resistor();r.variable(length=1.5);
Element z=Zresistor();z.variable(length=1.5);
join(A+19decal,B+19decal,r,z);
