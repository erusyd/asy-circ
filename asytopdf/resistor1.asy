import ElectricalComponents;
currentpen=fontsize(6);
size(100);
//serie1
Element e1=Circuit(Resistor("$R_2$"),
		   Resistor("$R_3$")).serie(25);
//parallel
Element e2=Circuit(Resistor("$R_4$"),
		   e1).parallel(20,branch=2);
//serie2
Element e3=Circuit(Resistor("$R_1$"),e2).serie(40);
		   
pair A=(0,0), B=(150,0);
//Ajout d'une flèche tension aux bornes du circuit
e3.addTension(Label("U",fontsize(8)),decal=2);
//Modification de la taille du sous-circuit
e3.size=2;
join(A,B,e3);
shipout(bbox(2mm,invisible));
