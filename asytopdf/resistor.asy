import ElectricalComponents;
size(200);
//serie
Element e=Circuit(Resistor("$R_1$",size=2),
		  Resistor("$R_2$",size=2)).serie(40);
		   
pair A=(0,0), B=(100,0);
join(A,B,e);

shipout(bbox(2mm,invisible));
