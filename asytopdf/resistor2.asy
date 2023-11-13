import ElectricalComponents;
size(200);
//parallel
Element e=Circuit(Resistor("$R_1$",size=2),
		  Resistor("$R_2$",size=2)
		  ).parallel(decal=40,hc=20,branch=1);
		   
pair A=(0,0), B=(100,0);
join(A,B,e);

shipout(bbox(2mm,invisible));
