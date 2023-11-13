import ElectricalComponents;
size(200);

pair A=(0,60),B=(40,60);
pair C=(0,40),D=(30,40);
pair F=(0,20),G=(40,20);
pair H=(0,0),I=(50,0),J=(50,40);
join(A,B,Intensity("$I_1$",fillpen=red));
join(B,D,Zresistor("$R_1$"));
join(C,D,Intensity("$I_2$",fillpen=red),
	Zresistor("$R_2$"));
join(G,D,Zresistor("$R_3$"));
join(F,G,Intensity("$I_3$",fillpen=red));
join(H,I,Ground(Label("neutre",align=2E)));
//arrows tension
join(H,A,Tension("$V_1$",drawpen=blue),dot=false);
join(H+(7,0),C+(7,0),Tension(Label("$V_2$",align=NW),
				drawpen=blue),dot=false);
join(H+(14,0),F+(14,0),Tension("$V_3$",drawpen=blue),
	dot=false);
draw(H--I--J--D);
shipout(bbox(2mm,invisible));
