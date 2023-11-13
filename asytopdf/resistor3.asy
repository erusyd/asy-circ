import ElectricalComponents;
size(300);

//parallel1
Element e1=
  Circuit(Resistor("$R_2=30\Omega$"),
	  Resistor("$R_1=10\Omega$")
	  ).parallel(20,10,branch=1);
//serie1
Element e2=
  Circuit(e1,Resistor("$R_3=2.5\Omega$")).serie(40);
//parallel2
Element e3=Circuit(Resistor("$R_6=20\Omega$"),
		   Resistor("$R_5=5\Omega$"))
  .parallel(20,10,branch=1);
//serie2
Element e4=Circuit(Resistor("$R_4=6\Omega$"),
		   e3).serie(40);
//parallel3
Element e5=Circuit(e4,e2).parallel(30,15,branch=1);	   
pair A=(0,0), B=(70,70);
//Ajout d'un commentaire à la totalité du circuit
e5.addLabel(Label("Un sous circuit",
		  fontsize(16)+blue));
join(A,B,e5);
shipout(bbox(2mm,invisible));
