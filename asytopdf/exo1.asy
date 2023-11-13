import ElectricalComponents;
size(200);

Element r=Resistor("R");
pair A=(0,0), B=(40,0);
join(A,B,r);

shipout(bbox(2mm,invisible));
