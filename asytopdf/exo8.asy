import ElectricalComponents;
size(200);

//circuit
Element n=PNP(center=(50,50));
n.draw();
pair B=n.connect(0), C=n.connect(1), Em=n.connect(2);
pair A=(40,B.y),D=(C.x,60),F=(Em.x,40);
//ajout du fil électrique
draw(A--B^^Em--F^^C--D);
//les points du circuit
dot(Label("A",align=N),A);
dot(Label("D",align=E),D);
dot(Label("F",align=E),F);
dot(Label("B",align=NW),B);
dot(Label("C",align=NW),C);
dot(Label("E",align=SW),Em);

shipout(bbox(2mm,invisible));
