import ElectricalComponents;
size(200);

pair A=(40,50), B=(150,10),C=(100,100);
pair D=(40,150),F=(140,150);
join(A,C,Intensity(size=1,type=1,"$I_1$",
		      fillpen=red,head=TeXHead));
join(B,C,Intensity(size=3,"$I_2$",
		      fillpen=blue+2,head=SimpleHead));
join(D,C,Intensity(size=3,type=1,"$I_3$",
		      fillpen=green,head=HookHead));
join(F,C,Intensity(size=3,"$I_4$",fillpen=orange));
dot("Noeud",C);

