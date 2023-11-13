import ElectricalComponents;
size(200);

pair A=(0,0), B=(100,0);
join(A,B,Resistor("$R_1$"),
     Resistor("$R_2$"),
     Resistor("$R_3$"));

shipout(bbox(2mm,invisible));
