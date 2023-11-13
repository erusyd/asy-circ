import ElectricalComponents;
usepackage("MajDroite");
usepackage("mathdesign","charter");
size(200);

Element n=NPN(Label("NPN",align=SW),center=(50,50));
n.draw();
pair B=n.connect(0), C=n.connect(2), E=n.connect(1);

pair A=(20,B.y),D=(E.x,80),F=(C.x,20);
pair G=(20,20),H=(70,20),I=(70,80);
join(A,B,Resistor("$R_B$"),
	Intensity("$I_B$",fillpen=red));
join(D,E,Resistor(rotate(90)*"$R_C$"),
	Intensity("$I_C$",fillpen=red));
join(G,A,Battery(rotate(-90)*"E",type=1));
join(H,I,Battery(Label(rotate(-90)*"E",align=S),
		 type=1));
join(C,F,Intensity("$I_E$",fillpen=red),
     Lamp(rotate(90)*"L",fillpen=yellow));
join(E+(2,0),C+(2,0),
     Tension(type=1, rotate(90)*"$V_{CE}$"),
	dot=false);
draw(G--H^^D--I);
shipout(bbox(2mm,invisible));
