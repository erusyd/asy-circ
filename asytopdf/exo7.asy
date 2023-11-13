import ElectricalComponents;
size(200);

Element r=Resistor(fillpen=pink);
Element c=Coil(drawpen=orange+1);
Element b=Battery();b.variable(rot=-45);
r.variable();
c.variable(length=.8,p=orange+1);
pair A=(0,0), B=(40,30), C=(40,0);
pair D=(0,30);
join(A,B,r);join(A,C,c);
join(A,D,b);

shipout(bbox(2mm,invisible));
