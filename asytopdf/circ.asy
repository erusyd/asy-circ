import ElectricalComponents;
import Circuit;
size(300);

Element d=Diode(Label("Diode",align=2N),size=4);
d.setPosition(.25);
//parallel coil,capacitor
Element e1=Circuit(Coil(Label("Coil",align=2S),size=4),
		   Capacitor(Label("$C_2$",align=N),
			     size=3)
		   ).parallel(30,hc=30/2,branch=1);
//parallel resistor,capacitor
Element e2=
  Circuit(Zresistor(Label("$R_3$",align=S),size=3),
	  Capacitor(Label("$C_3$",align=N),size=3)
	  ).parallel(30);
//parallel resistor,generator
Element e3=
  Circuit(Zresistor(Label("$R_4$",align=N),size=2),
	  IdealGen(rotate(-90)*"E=4V",size=2)
	  ).parallel(30,branch=2);
e3.setPosition(.75);
//points of the circuit
pair A=(0,0), B=(240,0), C=(0,150);
pair D=(120,270), E=(240,150), F=(120,30);
pair G=(120,150);
//circuit
join(A,B,Zresistor(Label("$R_1$",align=2N),size=3),
	Battery(size=4,
		Label("Battery",align=2N),
		Label("5 V",align=2S)));
join(C,D,Zresistor(Label("$R_2$",align=2N),size=3));
join(D,E,Capacitor(Label("$C_1$",align=2N),size=4));
join(C,F,e2);
join(F,E,e1);
join(C,E,d);
join(F,D,e3);
//draw wires
draw(C--A^^B--E);
//a grid for debug
addGrid(300,300,gray+3);
//contour
shipout(bbox(2mm,invisible));
