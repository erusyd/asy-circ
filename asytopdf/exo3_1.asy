import ElectricalComponents;
size(200);

pair A=(0,0), B=(100,0);
join(A,B,Resistor(size=2,angle=-20,fillpen=red+white),
     Resistor(size=2,angle=40,drawpen=green+1),
     Resistor(size=2,angle=-60,fillpen=blue+white));

shipout(bbox(2mm,invisible));
