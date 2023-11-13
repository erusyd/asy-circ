import ElectricalComponents;
size(200);

pair A=(0,40), B=(30,40), C=(60,40);
pair D=(0,0), F=(30,0), G=(60,0);
join(A,C,Lamp(fillpen=yellow),
	Switch("$K_1$"));
join(B,F,Lamp(fillpen=yellow));
join(D,A,Battery(sign=true,size=1.8));
join(D,G,Resistor(),Resistor());
join(G,C,Lamp());

shipout(bbox(2mm,invisible));
