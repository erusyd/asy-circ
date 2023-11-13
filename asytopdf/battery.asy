import ElectricalComponents;
size(200);

pair A=(0,0), B=(40,0);
join(A,B,Battery(size=1.8,sign=true),
     Battery(type=1,sign=true,size=1.8));

shipout(bbox(2mm,invisible));
