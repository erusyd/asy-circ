import ElectricalComponents;
import Circuit;
size(300);

currentpen=fontsize(10);
pair A=(0,50), B=(50,50);
Element e=Circuit(Resistor("$R_1$"),
		  Resistor("$R_2$"),
		  Resistor("$R_3$")
		  ).parallel(30,branch=2);
e.addLabel(Label("Center",align=N));
join(A,B,e);

pair A=(55,50), B=(105,50);
Element e=Circuit(Resistor("$R_1$",fillpen=red+white),
		  Resistor("$R_2$",fillpen=green+white),
		  Resistor("$R_3$",fillpen=blue+white)
		  ).parallel(25,branch=3);
e.addLabel(Label("Top",align=N));
join(A,B,e);

pair A=(110,50), B=(160,50);
Element e=Circuit(Resistor("$R_1$",drawpen=orange),
		  Resistor("$R_2$",drawpen=blue),
		  Resistor("$R_3$",drawpen=green)
		  ).parallel(20,branch=1);
e.addLabel(Label("Bottom",align=N));
join(A,B,e);

pair A=(165,50), B=(215,50);
Element e=Circuit(Diode(size=3,"$D_1$"),
		  Coil(size=2,"$coil$"),
		  Capacitor(size=2,"$C_1$")
		  ).parallel(decal=20,hc=20/2,branch=2);
e.addLabel(Label("Somewhere",align=N));
join(A,B,e);
