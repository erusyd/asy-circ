import ElectricalComponents;
size(200);

Element r=Resistor(size=2,fillpen=green+white);
r.setPosition(.2);
Element b=Battery(sign=true,size=2);
b.setPosition(.8);
pair A=(0,0), B=(100,0);
join(A,B,r,b);

shipout(bbox(2mm,invisible));
