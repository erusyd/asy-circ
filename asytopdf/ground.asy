import ElectricalComponents;
size(200);

pair A=(0,0), B=(40,0);
join(A,B,Ground(size=1.5),
     Ground(size=1.5,type=1));

shipout(bbox(2mm,invisible));
