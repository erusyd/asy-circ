import ElectricalComponents;
size(200);
Element r1=Resistor((19,9),angle=20,
		    fillpen=blue+white);
Element r2=Coil((30,13),size=1.5,angle=20,
		drawpen=green+2);
Element r3=Tension(center=(19,4),
		   rotate(90)*"$\vec{P}$",
		   angle=-90,drawpen=red+1);
Element r4=Tension(center=(18,12),
		   Label(rotate(-90)*"$\vec{R}$",
			 align=NE),
		   angle=110,drawpen=red+1);
r1.draw(); pair[] c1=r1.connectors();
r2.draw(); pair[] c2=r2.connectors();
r3.draw();r4.draw();

draw(Label("$\vec{T}$",black,align=N),
     c1[1]--c2[1],
     red+1,
     Arrow(6));
pair A=(40,0);
draw((0,0)--A^^(0,0)--rotate(20)*A);
draw(c2[0]--c1[1]);
