import ElectricalComponents;
size(200);
//Les éléments
Element r3=Coil((20,30),size=2,angle=-90,
		drawpen=green+2);
Element r4=Tension(center=(20,5),
		   rotate(90)*"$\vec{P}$",
		   angle=-90,drawpen=red+1);
Element r1=Resistor((20,10),angle=-90,
		    fillpen=blue+white);
//Dessin des éléments
r1.draw(); pair[] c1=r1.connectors();
r3.draw(); pair[] c3=r3.connectors();
r4.draw(); pair[] c4=r4.connectors();
draw(c3[1]--c1[0]);
