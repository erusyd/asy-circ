import ElectricalComponents;
size(200);

pair A=(0,0), B=(40,30);
join(A,B,Diode(size=2,fillpen=yellow),
     Coil(drawpen=red+2));
dot("A",A);dot("B",B);
shipout(bbox(2mm,invisible));
