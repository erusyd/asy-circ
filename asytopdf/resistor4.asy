import ElectricalComponents;
size(300);

//parallel1
Element e1=
  Circuit(Resistor(),
	  Resistor()
	  ).parallel(20,10,branch=1);
//serie1
Element e2=
  Circuit(e1,Resistor()).serie(40);
//parallel2
Element e3=Circuit(Resistor(),
		   Resistor())
  .parallel(20,10,branch=1);
//serie2
Element e4=Circuit(Resistor(),
		   e3).serie(40);
//parallel3
Element e5=Circuit(e4,e2).parallel(30,15,branch=1);	   
pair A0=(0,0), B0=(100,100);
//Ajout d'un commentaire à la totalité du circuit
e5.addLabel(Label("Un sous circuit",
		  fontsize(16)+blue));

int j=0;
pair[] C;
void recurs(pair A, pair B){
  for(int i=0;i<4;++i){
    Element c1=e5.copy();
    if(i>1){
      c1.angle=45;
      C.push(rotate(90*i,A)*B);
      join(A,C[C.length-1],c1);
    }
  }
  for(int i=0;i<4;++i){
    Element c1=e5.copy();
    if(i<2){
      c1.angle=45;
      C.push(rotate(90*i,A)*B);
      join(A,C[C.length-1],c1);
    }
  }
  if(j<1){
    ++j;
    for(int i=C.length-1;i<500;++i){
      recurs(C[i],shift(100,100)*C[i]);
    }
  }
}

recurs(A0,B0);
shipout(bbox(2mm,invisible));
