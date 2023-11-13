/*
  Developped by Christophe CASSEAU
  April 2010
 */
struct Element{
  /*Position of the absolute center of element
    in user coordinates
   */
  pair center;
  //relative position on wire
  real position=0;
  //angle of rotation relative to the wire
  real angle;
  //size element
  real size=1;
  //picture element
  picture pic_element;
  //coordinates of pic_element
  pair mini,maxi;
  bool exist=false;
  //use arrows tension and intensity
  bool intensity=false;
  bool u=false;
  //use labels
  pair posL;
  Label labe;

  //set a new center position
  void setCenter(pair center){
    this.center=center;
  }
  //return the center of element
  pair getCenter(){
    return center;
  }
  //Place an element with a relative position
  //between two points (.5=middle)
  void setPosition(real rel){
    position=rel;
  }
  //Return relative position
  real getPosition(){
    return position;
  }
  
  //return path of complex element
  path[] getPathElement(){
    path[] p;
    if(exist==false){
      exist=true;
      mini=min(pic_element);maxi=max(pic_element);
    }
    p[0]=mini--(maxi.x,mini.y)--maxi--(mini.x,maxi.y)--cycle;
    return p;
  }

  //only for developper
  void box(real xscale=1, real yscale=1,real x=0,real y=0,
	   pen fillpen=paleblue+opacity(.5), pen drawpen=red+dashed){
    path[] p=getPathElement();
    p=xscale(xscale)*p;
    p=yscale(yscale)*p;
    p=shift(x,y)*p;
    filldraw(pic_element,p,fillpen,drawpen);
  }
  
  //project Circuit
  void setPathElement(path[] p);
  void setPicElement(picture pic){
    pic_element=pic;
  }

  // Draw element picture
  void draw(){
    label(pic_element,labe,posL);
    picture p=shift(center)*rotate(angle)*scale(size)*pic_element;
    frame F=p.fit();
    add(new void(picture pic, transform t){
	add(pic,t*p);
      });
    currentpicture.addBox(min(F),max(F));
  }
  
  //Connectors of element in user coordinates
  pair[] connectors();

  //choice connection
  pair connect(int n){
    pair[] c=connectors();
    if(n<c.length)
      return c[n];
    else
      return c[0];
  }

  //not definitive copy element
  Element copy(){
    Element e=new Element;
    e.pic_element=pic_element;
    e.setCenter(getCenter());
    e.size=size;
    e.angle=angle;
    e.connectors=new pair[](){
      return e.center+rotate(e.angle)*connectors();
    };
    return e;
  }

  //add label with angle position
  void addLabel(Label L,real rot=90){
    path p=(0,0)--((size*abs(max(pic_element)),0));
    p=rotate(degrees(dir(rot)),(0,0))*p;
    pair ptc=intersectionpoint(getPathElement()[0],p);
    posL=ptc;
    labe=L;
    if(L.align.dir==0)
      labe.align.dir=N;
  }

  //add arrow tension
  void addTension(int type=0,Label L,real rot=90,real decal=1.2,real multlength=1,pen pen=black){
    path p=(0,0)--(size*abs(max(pic_element)),0);
    p=rotate(degrees(dir(rot)),(0,0))*p;
    pair ptc=intersectionpoint(getPathElement()[0],p);
    pair length=max(getPathElement()[0]);
    length=multlength*length;
    if(L.align.dir==0)
      L.align=N;
    if(type==0)
      draw(pic_element,L,((ptc.x,decal*ptc.y)-length.x)--
	   ((ptc.x,decal*ptc.y)+length.x),p=pen,Arrow);
    else
      draw(pic_element,L,((ptc.x,decal*ptc.y)+length.x)--
	   ((ptc.x,decal*ptc.y)-length.x),p=pen,Arrow);
  }

  void variable(real length=1,real rot=45,pen p=currentpen){
    draw(pic_element,
	 rotate(rot,(0,0))*scale(length)*((-6,0)--(6,0)),
	 Arrow(6),
	 p=p);
  }
  
  //for debug mode: circular grid around component
  void addCircGrid(int n=4){
    path p=getPathElement()[0];
    pair tb=getCenter();
    path vec=tb--(200,0);
    path rot=rotate(90,tb)*vec;
    pair pts=intersectionpoint(p,rot);
    real rc=pts.y;
    path[] c;
    for(int i=0;i<n;++i){
      c[i]=circle(tb,rc);
      draw(pic_element,c[i],gray);
      rc=rc+5/size;
    }
    for(int i=0;i<360;i=i+30){
      string s=(string)i;
      path rot=rotate(i,tb)*vec;
      pair ptc=intersectionpoint(c[c.length-1],rot);
      if(i<180)
	label(pic_element,Label(s,fontsize(8)),ptc,align=2N);
      else
	label(pic_element,Label(s,fontsize(8)),ptc,align=2S);
      dot(pic_element,ptc,blue+2);
      draw(pic_element,tb--ptc,gray);
    }
  }
}
//add linear connexion between two Elements
path[] operator --(pair pt,Element e){
  path[] p;
  pair[] c=e.connectors();
  p.push(pt..c[0]);
  p.push(c[c.length-1]);
  return p;
}

path[] operator --(Element e1,Element e2){
  pair[] c1,c2;
  path[] p;
  c1=e1.connectors(); c2=e2.connectors();
  p.push(c1[c1.length-1]..c2[0]);
  p.push(c2[c2.length-1]);
  return p;
}

path[] operator --(path[] p, Element e){
  pair[] c=e.connectors();
  p[p.length-1]=p[p.length-1]--c[0];
  p.push(c[c.length-1]);
  return p;
}

path[] operator --(Element e, path[] p){
  pair[] c=e.connectors();
  return c[c.length-1]--p[0]^^p;
}

//Draw an electrical branch
void join(pair A, pair B,bool dot=true ...Element[] e){
  path[] p;
  pair[] prec,suiv;
  if(dot==true){
    dot(A,red+2);
    dot(B,red+2);
  }
  pair dir=dir(B-A);
  pair pos=A;
  int count_element=0;
  /*
    Calcul automatique de la position du centre du composant.
    width_element=longueur totale AB - somme des longueurs
    de chaque composant(N) le tout divisé par N+1
    On obtient un écartement constant entre les composants
   */
  real width_elements=0;
  for(int i=0;i<e.length;++i){
    width_elements=width_elements+
      2*max(scale(e[i].size)*e[i].getPathElement()).x;
    if(e[i].intensity!=true)
      ++count_element;
  }
  if(count_element==0)
    ++count_element;
  real d=(abs(A-B)-width_elements)/(count_element+1);
  for(int i=0;i<e.length;++i){
    e[i].angle=e[i].angle+degrees(dir);
    if(e[i].position==0){
      if(i>0)
	if(e[i-1].intensity==true || e[i].intensity==true){
	  pos=pos+d/2*dir+
	    (max(scale(e[i-1].size)*e[i-1].getPathElement()).x)*dir+
	    (max(scale(e[i].size)*e[i].getPathElement()).x)*dir;
	}
	else
	  pos=pos+d*dir+
	    (max(scale(e[i-1].size)*e[i-1].getPathElement()).x)*dir+
	    (max(scale(e[i].size)*e[i].getPathElement()).x)*dir;
      else{
	pos=pos+(max(scale(e[i].size)*e[i].getPathElement()).x)*dir+
	  d*dir;
      }
    }
    else{
      pos=A+abs(A-B)*e[i].getPosition()*dir;
    }
    //Affectation de la position du centre à l'élément
    e[i].setCenter(pos);
    //tracer du fil entre les composants
    suiv=e[i].connectors();
    if(e[i].u!=true){
      if(i>0){
	prec=e[i-1].connectors();
	draw(prec[prec.length-1]..suiv[0]);
      }
      else
	draw(A..suiv[0]);
    }
    //Cas particulier des flèches tensions.
    //On ne veut pas relier les extrémités.
    if(e[i].u==true)
      if(e[i].size==1)
	e[i].size=abs(A-B)/11;
      else
	e[i].size=abs(A-B)*(e[i].size*.1);
    //gestion de la position des labels quand l'élément
    //se retrouve la tête en bas.
    if(dir(B-A).x<0){
      e[i].labe.align.dir=-1*e[i].labe.align.dir;
      e[i].labe=rotate(180)*e[i].labe;
      e[i].posL=rotate(180,(0,0))*e[i].posL;
    }
    //dessin de l'élément
    e[i].draw();
  }//fin for
  if(e[e.length-1].u!=true)
    draw(suiv[suiv.length-1]..B);
}

//a test for tripole but not satisfaisant
path[] join(pair A, pair B,pair C, Element e){
  path[] p;
  //on place le composant afin de d'initialiser
  //les connecteurs
  real posx;//On cherche la plus petite longueur
  if(dir(A-B).x>=0)
    posx=A.x+abs(C.x-A.x)/2;
  else
    posx=B.x+abs(C.x-B.x)/2;
  real posy=C.y;
  //position de l'element pour l'instant au milieu
  pair pos=(posx,posy);
  e.setCenter(pos);
  e.draw();
  //On récupère les connections de l'element
  pair[] c=e.connectors();
  //
  pair coudeh0,coudeh1,coudeb0,coudeb1;
  //Le coude bas
  coudeb0=(max(A.x,B.x)+(c[0].x-max(A.x,B.x))/2,A.y);
  coudeb1=(max(A.x,B.x)+(c[0].x-max(A.x,B.x))/2,c[0].y);
  //le coude haut
  coudeh0=(max(A.x,B.x)+(c[0].x-max(A.x,B.x))/2,B.y);
  coudeh1=(max(A.x,B.x)+(c[0].x-max(A.x,B.x))/2,c[1].y);
  //les fils
  p=(A--coudeb0--coudeb1--c[0])^^
    (B--coudeh0--coudeh1--c[1])^^
    (c[2]--C);
  return p;
}

void addGrid(picture pic=currentpicture,
	     int x=(int)max(currentpicture).x,
	     int y=(int)max(currentpicture).y,
	     int griddivx=10,
	     int griddivy=10,
	     pen pen=black){
  real yStep=y/griddivy;
  real xStep=x/griddivx;
  path[] p1,p2;
  string maxy="("+(string)(x/griddivx)+
    ","+(string)(y/griddivy)+")";
  
  //lignes horizontales
  for(real i=0;i<=y;i=i+yStep)
    p1=p1^^(0,i)--(x,i);
  
  //lignes verticales
  for(real i=0;i<=x;i=i+xStep)
    p2=p2^^(i,0)--(i,y);
  
  add(new void(picture pic, transform t){
      dot(pic,Label(s=maxy,t*(xStep,yStep),align=N,red));
      for(int i=0;i<p1.length;++i)
	for(int j=0;j<p2.length;++j){
	  draw(pic,t*intersectionpoints(p1[i],p2[j]),pen);
	}
    });  
}
