import ElectricalComponents;
size(200);

pair A=(0,0), B=(100,0);
join(A,B,Resistor(Label("$R_1$",align=S),
		  size=2,
		  fillpen=red+white,
		  drawpen=red+1),
     Coil(Label("Coil",align=NW),
	  size=2,
	  drawpen=blue+white+2),
     Diode(Label("Diode",align=3SE),
	   size=2,
	   fillpen=green+white));

shipout(bbox(2mm,invisible));
