import ElectricalComponents;
size(200);

pair A=(0,0), B=(40,0);
Element r=Resistor();r.variable();
Element z=Zresistor();z.variable();
join(A,B,r,z);

shipout(bbox(2mm,invisible));
