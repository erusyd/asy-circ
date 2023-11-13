import ElectricalComponents;
import Circuit;
import math;
real size=200;
size(size);

Element r=Resistor("R");
r.addTension(type=1,Label("$\mathrm{U_R}$",blue),
	     decal=3,multlength=1.5,pen=green);
r.setPosition(.7);
Element i=Intensity(Label("I",orange),fillpen=red);
i.setPosition(.2);
pair A=(0,0), B=(40,0);
join(A,B,i,r);
shipout(bbox(2mm,invisible));
