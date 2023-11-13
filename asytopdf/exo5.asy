import ElectricalComponents;
import Circuit;
import math;
real size=200;
size(size);

Element r=Battery(type=1,sign=true);
r.addTension(Label("E",align=N,blue),
	     multlength=8,pen=green);
r.setPosition(.7);
Element i=Intensity(Label("I",orange),fillpen=red);
i.setPosition(.3);
pair A=(0,0), B=(30,0);
join(A,B,i,r);
shipout(bbox(2mm,invisible));
