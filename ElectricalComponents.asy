/*
  Developped by Christophe CASSEAU
  April 2010
 */
import Element;
import Circuit;
import fontsize;
usepackage("inputenc","utf8");
currentpen=fontsize(11);

struct Resistor{

  Element element;
  private bool help;
  private pen fillpen,drawpen;


  //return paths element
  path[] shape(){
    path[] p;
    p[0]=(0,2)--(0,-2)--(8,-2)--(8,2)--cycle;
    return shift(-4)*p;
  }

  //Return a picture element
  picture picElement(){
    picture resistor;
    path[] p=shape();
    filldraw(resistor,p[0],fillpen,drawpen);
    return resistor;
  }
  
  void operator init(pair center=(0,0),real size=1,
		     real angle=0,pen fillpen=invisible,
		     pen drawpen=currentpen ... Label[] L){
    this.fillpen=fillpen;
    this.drawpen=drawpen;
    this.help=help;
    element.angle=angle;
    element.center=center;
    element.size=size;
    element.pic_element=picElement();
    for(int i=0;i<L.length;++i)
      if(L[i].align.dir!=0)
	element.addLabel(L[i],degrees(dir(L[i].align.dir)));
      else
	element.addLabel(L[i]);
  }

  

  element.getPathElement=new path[](){
    return shape();
  };
  
  element.connectors=new pair[](){
    //points connectors
    pair[] c;
    c[0]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),W);
    c[1]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),E);
    //dots connectors
    // //dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),W));
//     dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),E));
    return c;
  };
}

struct Zresistor{

  Element element;
  private bool help;
  private pen fillpen,drawpen;


  //return paths element
  path[] shape(){
    path bounding_box=(0,1)--(0,-1)--(5.5,-1)--(5.5,1)--cycle;
    path[] p;
    path start,end;
    start=(0,0)--(.5,-1);
    end=(4.5,-1)--(5,1)--(5.5,0);
    for(int i=0;i<4;++i)
      p[i]=(i+.5,-1)--(i+1,1)--(i+1.5,-1);
    return shift(-4.125)*(scale(1.5)*(bounding_box^^start^^p^^end));
  }

  //Return a picture element
  picture picElement(){
    picture resistor;
    path[] p=shape();
    filldraw(resistor,p[0],invisible,invisible);
    for(int i=1;i<p.length;++i)
      draw(resistor,p[i],drawpen);
    return resistor;
  }
  
  void operator init(pair center=(0,0),real size=1,
		     real angle=0,pen fillpen=invisible,
		     pen drawpen=currentpen ... Label[] L){
    this.fillpen=fillpen;
    this.drawpen=drawpen;
    this.help=help;
    element.angle=angle;
    element.center=center;
    element.size=size;
    element.pic_element=picElement();
    for(int i=0;i<L.length;++i)
      if(L[i].align.dir!=0)
	element.addLabel(L[i],degrees(dir(L[i].align.dir)));
      else
	element.addLabel(L[i]);
  }

  

  element.getPathElement=new path[](){
    return shape();
  };
  
  element.connectors=new pair[](){
    //points connectors
    pair[] c;
    c[0]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),W);
    c[1]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),E);
    //dots connectors
    // //dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),W));
//     dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),E));
    return c;
  };
}


//variable resistor
struct Potentiometer{

  Element element;
  private bool help;
  private pen fillpen,drawpen;


  //return paths element
  path[] shape(){
    path bounding_box=(0,5)--(0,-2)--(8,-2)--(8,5)--cycle;
    path[] p;
    p[0]=(0,2)--(0,-2)--(8,-2)--(8,2)--cycle;
    p[1]=(4,5)--(4,2);
    return shift(-4)*(bounding_box^^p);
  }

  //Return a picture element
  picture picElement(){
    picture resistor;
    path[] p=shape();
    filldraw(resistor,p[0],invisible,invisible);
    filldraw(resistor,p[1],fillpen,drawpen);
    draw(resistor,p[2],drawpen,Arrow(6));
    return resistor;
  }
  
  void operator init(pair center=(0,0),real size=1,
		     real angle=0,pen fillpen=invisible,
		     pen drawpen=currentpen ... Label[] L){
    this.fillpen=fillpen;
    this.drawpen=drawpen;
    this.help=help;
    element.angle=angle;
    element.center=center;
    element.size=size;
    element.pic_element=picElement();
    for(int i=0;i<L.length;++i)
      if(L[i].align.dir!=0)
	element.addLabel(L[i],degrees(dir(L[i].align.dir)));
      else
	element.addLabel(L[i]);
  }

  

  element.getPathElement=new path[](){
    return shape();
  };
  
  element.connectors=new pair[](){
    pair c0=(-1,-.42);
    pair c1=(0,1);
    pair c2=(1,-.42);
    //points connectors
    pair[] c;
    c[0]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),c0);
    c[1]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),c1);
    c[2]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),c2);
    //dots connectors
    // //dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),W));
//     dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),E));
    return c;
  };
}

//Diode
struct Diode{

  Element element;
  private bool help;
  private pen fillpen,drawpen;
  private real type;

  path[] shape(){
    path p1=(0,1.2)--(0,-1.2)--(3.5,0)--cycle;
    path p2=(3.5,-1.2)--(3.5,1.2)--cycle;
    if(type==0)
      return shift(-1.75)*(p1^^p2);
    else
      return shift(-1.75)*rotate(180,(1.75,0))*(p1^^p2);
  }
  
  picture picElement(){
    picture diode;
    filldraw(diode,shape()[0],fillpen,drawpen);
    filldraw(diode,shape()[1],fillpen,drawpen);
    return diode;
  }

  void operator init(real type=0,pair center=(0,0),real size=1,
		     real angle=0,pen fillpen=invisible,
		     pen drawpen=currentpen ... Label[] L){
    this.type=type;
    this.fillpen=fillpen;
    this.drawpen=drawpen;
    this.help=help;
    element.angle=angle;
    element.center=center;
    element.size=size;
    element.pic_element=picElement();
    for(int i=0;i<L.length;++i)
      if(L[i].align.dir!=0)
	element.addLabel(L[i],degrees(dir(L[i].align.dir)));
      else
	element.addLabel(L[i]);
  }

  element.getPathElement=new path[](){
    return shape();
  };

  element.connectors=new pair[](){
    //connectors
    pair[] c;
    c[0]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),W);
    c[1]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),E);
    //dot connectors
    // dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),W));
//     dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),E));
    return c;
  };
}

struct Zener{

  Element element;
  private bool help;
  private pen fillpen,drawpen;

  path[] shape(){
    path p1=(0,1.2)--(0,-1.2)--(3.5,0)--cycle;
    path p2=(2,-1.2)--(3.5,-1.2)--(3.5,1.2);
    return shift(-1.75)*(p1^^p2);
  }
  
  picture picElement(){
    picture diode;
    filldraw(diode,shape()[0],fillpen,drawpen);
    draw(diode,shape()[1],drawpen);
    return diode;
  }

  void operator init(pair center=(0,0),real size=1,
		     real angle=0,pen fillpen=invisible,
		     pen drawpen=currentpen ... Label[] L){
    this.fillpen=fillpen;
    this.drawpen=drawpen;
    this.help=help;
    element.angle=angle;
    element.center=center;
    element.size=size;
    element.pic_element=picElement();
    for(int i=0;i<L.length;++i)
      if(L[i].align.dir!=0)
	element.addLabel(L[i],degrees(dir(L[i].align.dir)));
      else
	element.addLabel(L[i]);
  }

  element.getPathElement=new path[](){
    return shape();
  };

  element.connectors=new pair[](){
    //connectors
    pair[] c;
    c[0]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),W);
    c[1]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),E);
    //dot connectors
    // dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),W));
//     dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),E));
    return c;
  };
}

//transystor
struct NPN{

  Element element;
  private bool help;
  private pen fillpen,drawpen;
  private real type;

  path[] shape(){
    path bounding_box=(0,2.5)--(0,-2.5)--(3.5,-2.5)--(3.5,2.5)--cycle;
    path p1=(0,2.5)--(0,-2.5)--(.2,-2.5)--(.2,2.5)--cycle;
    path p2=(0,.5)--(3.5,3.5);
    path p3=(0,-.5)--(3.5,-3.5);
    return shift(-1.75)*(bounding_box^^p1^^p2^^p3);
  }
  
  picture picElement(){
    picture npn;
    filldraw(npn,shape()[0],invisible,invisible);
    filldraw(npn,shape()[1],fillpen=black,drawpen);
    draw(npn,shape()[2],drawpen);
    draw(npn,shape()[3],drawpen,MidArrow());
    return npn;
  }

  void operator init(real type=0,pair center=(0,0),real size=1,
		     real angle=0,pen fillpen=invisible,
		     pen drawpen=currentpen ... Label[] L){
    this.type=type;
    this.fillpen=fillpen;
    this.drawpen=drawpen;
    this.help=help;
    element.angle=angle;
    element.center=center;
    element.size=size;
    element.pic_element=picElement();
    for(int i=0;i<L.length;++i)
      if(L[i].align.dir!=0)
	element.addLabel(L[i],degrees(dir(L[i].align.dir)));
      else
	element.addLabel(L[i]);
  }

  element.getPathElement=new path[](){
    return shape();
  };

  element.connectors=new pair[](){
    //connectors
    pair c1=(1,1);
    pair c2=(1,-1);
    pair[] c;
    c[0]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),W);
    c[1]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),c1);
    c[2]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),c2);
    //dot connectors
    //dot(element.center+
    //rotate(element.angle)*scale(element.size)*point(picElement(),c1));
    //dot(element.center+
    //rotate(element.angle)*scale(element.size)*point(picElement(),E));
    return c;
  };
}

//transystor
struct PNP{

  Element element;
  private bool help;
  private pen fillpen,drawpen;
  private real type;

  path[] shape(){
    path bounding_box=(0,2.5)--(0,-2.5)--(3.5,-2.5)--(3.5,2.5)--cycle;
    path p1=(0,2.5)--(0,-2.5)--(.2,-2.5)--(.2,2.5)--cycle;
    path p2=(0,.5)--(3.5,3.5);
    path p3=(3.5,-3.5)--(0,-.5);
    return bounding_box^^p1^^p2^^p3;
  }
  
  picture picElement(){
    picture pnp;
    filldraw(pnp,shape()[0],invisible,invisible);
    filldraw(pnp,shape()[1],fillpen=black,drawpen);
    draw(pnp,shape()[2],drawpen);
    draw(pnp,shape()[3],drawpen,MidArrow());
    return pnp;
  }

  void operator init(real type=0,pair center=(0,0),real size=1,
		     real angle=0,pen fillpen=invisible,
		     pen drawpen=currentpen ... Label[] L){
    this.type=type;
    this.fillpen=fillpen;
    this.drawpen=drawpen;
    this.help=help;
    element.angle=angle;
    element.center=center;
    element.size=size;
    element.pic_element=picElement();
    for(int i=0;i<L.length;++i)
      if(L[i].align.dir!=0)
	element.addLabel(L[i],degrees(dir(L[i].align.dir)));
      else
	element.addLabel(L[i]);
  }

  element.getPathElement=new path[](){
    return shape();
  };

  element.connectors=new pair[](){
    //connectors
    pair c1=(1,1);
    pair c2=(1,-1);
    pair[] c;
    c[0]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),W);
    c[1]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),c1);
    c[2]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),c2);
    //dot connectors
    //dot(element.center+
    //rotate(element.angle)*scale(element.size)*point(picElement(),c1));
    //dot(element.center+
    //rotate(element.angle)*scale(element.size)*point(picElement(),E));
    return c;
  };
}

//Coil
struct Coil{

  Element element;
  private bool help;
  private pen fillpen,drawpen;

  path[] shape(){
    guide Pcoil;
    path bounding_box=(0,1.2)--(0,-1.2)--(9,-1.2)--(9,1.2)--cycle;
    for (int t=0;t<15;++t){
      //max(9,1.2)
      Pcoil=Pcoil..(t/2+1-cos(3.1415926*t/2),1.2*sin(3.1415926*t/2));
    }
    return shift(-4.5)*(bounding_box^^Pcoil);
  }
  
  picture picElement(){
    picture coil;
    filldraw(coil,shape()[0],invisible,invisible);
    draw(coil,shape()[1],drawpen);
    return coil;
  }

  void operator init(pair center=(0,0),real size=1,
		     real angle=0,pen fillpen=invisible,
		     pen drawpen=currentpen ... Label[] L){
    this.fillpen=fillpen;
    this.drawpen=drawpen;
    this.help=help;
    element.angle=angle;
    element.center=center;
    element.size=size;
    element.pic_element=picElement();
    for(int i=0;i<L.length;++i)
      if(L[i].align.dir!=0)
	element.addLabel(L[i],degrees(dir(L[i].align.dir)));
      else
	element.addLabel(L[i]);
  }

  element.getPathElement=new path[](){
    return shape();
  };

  element.connectors=new pair[](){
    //connectors
    pair[] c;
    c[0]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),W);
    c[1]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),E);
    //dot connectors
    // dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),W));
//     dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),E));
    return c;
  };
}

//lamp
struct Lamp{

  Element element;
  private bool help;
  private pen fillpen,drawpen;

  path[] shape(){
    path p1,p2,p3;
    p1=circle((0,0),3);
    p2=(3Cos(45),3Sin(45))--(-3Cos(45),-3Sin(45));
    p3=(-3Cos(40),3Sin(40))--(3Cos(40),-3Sin(40));
    return p1^^p2^^p3;
  }
  
  picture picElement(){
    picture lamp;
    filldraw(lamp,shape()[0],fillpen,drawpen);
    draw(lamp,shape()[1],drawpen);
    draw(lamp,shape()[2],drawpen);
    return lamp;
  }

  void operator init(pair center=(0,0),real size=1,
		     real angle=0,pen fillpen=invisible,
		     pen drawpen=currentpen ... Label[] L){
    this.fillpen=fillpen;
    this.drawpen=drawpen;
    this.help=help;
    element.angle=angle;
    element.center=center;
    element.size=size;
    element.pic_element=picElement();
    for(int i=0;i<L.length;++i)
      if(L[i].align.dir!=0)
	element.addLabel(L[i],degrees(dir(L[i].align.dir)));
      else
	element.addLabel(L[i]);
  }

  element.getPathElement=new path[](){
    return shape();
  };

  element.connectors=new pair[](){
    //connectors
    pair[] c;
    c[0]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),W);
    c[1]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),E);
    //dot connectors
    // dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),W));
//     dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),E));
    return c;
  };
}

//IdealGen
struct IdealGen{

  Element element;
  private bool help;
  private pen fillpen,drawpen;

  path[] shape(){
    path p1,p2;
    p1=circle((0,0),4);
    p2=(-4,0)--(4,0);
    return p1^^p2;
  }
  
  picture picElement(){
    picture gen;
    filldraw(gen,shape()[0],fillpen,drawpen);
    draw(gen,shape()[1],drawpen);
    return gen;
  }

  void operator init(pair center=(0,0),real size=1,
		     real angle=0,pen fillpen=invisible,
		     pen drawpen=currentpen ... Label[] L){
    this.fillpen=fillpen;
    this.drawpen=drawpen;
    this.help=help;
    element.angle=angle;
    element.center=center;
    element.size=size;
    element.pic_element=picElement();
    for(int i=0;i<L.length;++i)
      if(L[i].align.dir!=0)
	element.addLabel(L[i],degrees(dir(L[i].align.dir)));
      else
	element.addLabel(L[i]);
  }

  element.getPathElement=new path[](){
    return shape();
  };

  element.connectors=new pair[](){
    //connectors
    pair[] c;
    c[0]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),W);
    c[1]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),E);
    //dot connectors
    // dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),W));
//     dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),E));
    return c;
  };
}

//Icc
struct Icc{

  Element element;
  private bool help;
  private pen fillpen,drawpen;

  path[] shape(){
    path p1,p2;
    p1=circle((0,0),4);
    p2=(0,-4)--(0,4);
    return p1^^p2;
  }
  
  picture picElement(){
    picture gen;
    filldraw(gen,shape()[0],fillpen,drawpen);
    draw(gen,shape()[1],drawpen);
    return gen;
  }

  void operator init(pair center=(0,0),real size=1,
		     real angle=0,pen fillpen=invisible,
		     pen drawpen=currentpen ... Label[] L){
    this.fillpen=fillpen;
    this.drawpen=drawpen;
    this.help=help;
    element.angle=angle;
    element.center=center;
    element.size=size;
    element.pic_element=picElement();
    for(int i=0;i<L.length;++i)
      if(L[i].align.dir!=0)
	element.addLabel(L[i],degrees(dir(L[i].align.dir)));
      else
	element.addLabel(L[i]);
  }

  element.getPathElement=new path[](){
    return shape();
  };

  element.connectors=new pair[](){
    //connectors
    pair[] c;
    c[0]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),W);
    c[1]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),E);
    //dot connectors
    // dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),W));
//     dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),E));
    return c;
  };
}

//Motor
struct Motor{

  Element element;
  private bool help;
  private pen fillpen,drawpen;
  private int type=0;
  private real rotM;

  path[] shape(){
    path p1,p2,p3;
    path[] p4;
    p1=circle((0,0),5);
    p2=box((5,-.5),(5.5,.5));
    p3=box((-5,-.5),(-5.5,.5));
    p4=texpath(Label("M",fontsize(8)));
    return p1^^p2^^p3^^p4;
  }
  
  picture picElement(){
    picture motor;
    filldraw(motor,shape()[0],fillpen,drawpen);
    filldraw(motor,shape()[1],fillpen=black,drawpen);
    filldraw(motor,shape()[2],fillpen=black,drawpen);
    filldraw(motor,rotate(rotM)*shape()[3],drawpen);
    return motor;
  }

  void operator init(real rotM=0,pair center=(0,0),real size=1,
		     real angle=0,pen fillpen=invisible,
		     pen drawpen=currentpen ... Label[] L){
    this.type=type;
    this.rotM=rotM;
    this.fillpen=fillpen;
    this.drawpen=drawpen;
    this.help=help;
    element.angle=angle;
    element.center=center;
    element.size=size;
    element.pic_element=picElement();
    for(int i=0;i<L.length;++i)
      if(L[i].align.dir!=0)
	element.addLabel(L[i],degrees(dir(L[i].align.dir)));
      else
	element.addLabel(L[i]);
  }

  element.getPathElement=new path[](){
    return shape();
  };

  element.connectors=new pair[](){
    //connectors
    pair[] c;
    c[0]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),W);
    c[1]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),E);
    //dot connectors
    // dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),W));
//     dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),E));
    return c;
  };
}

//Multimeter
struct Multi{

  Element element;
  private bool help;
  private pen fillpen,drawpen;
  private int type=0;
  private real rot;
  private string s;

  path[] shape(){
    path p1;
    path[] p2;
    p1=circle((0,0),4);
    p2=texpath(Label(s,fontsize(6)));
    return p1^^p2;
  }
  
  picture picElement(){
    picture multi;
    filldraw(multi,shape()[0],fillpen,drawpen);
    filldraw(multi,rotate(rot)*shape()[1],drawpen);
    for(int i=2;i<shape().length;++i)
      filldraw(multi,rotate(rot)*shape()[i],fillpen=white,drawpen);
    return multi;
  }

  void operator init(real rot=0,string s="V",pair center=(0,0),real size=1,
		     real angle=0,pen fillpen=invisible,
		     pen drawpen=currentpen ... Label[] L){
    this.type=type;
    this.rot=rot;
    this.s=s;
    this.fillpen=fillpen;
    this.drawpen=drawpen;
    this.help=help;
    element.angle=angle;
    element.center=center;
    element.size=size;
    element.pic_element=picElement();
    for(int i=0;i<L.length;++i)
      if(L[i].align.dir!=0)
	element.addLabel(L[i],degrees(dir(L[i].align.dir)));
      else
	element.addLabel(L[i]);
  }

  element.getPathElement=new path[](){
    return shape();
  };

  element.connectors=new pair[](){
    //connectors
    pair[] c;
    c[0]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),W);
    c[1]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),E);
    return c;
  };
}

//generator
struct Battery{

  Element element;
  private bool sign;
  private pen fillpen,drawpen;
  private real type;
  
  path[] shape(){
    path p1,p2,p3,p4;
    path[] plus,moins,final;
    moins=texpath(Label("-",fontsize(1)));
    plus=texpath(Label("+",fontsize(.7)));
    path bounding_box=(-.6,3)--(-.6,-3)--(.6,-3)--(.6,3)--cycle;
    if(type==0){
      if(sign==true){
	plus=(shift(-1.2,2.4)*plus);
	moins=(shift(1.3,2.4)*moins);
	final=plus^^moins;
      }
      p1=(-.5,3)--(-.5,-3);
      p2=(.5,1.5)--(.5,-1.5)--(.8,-1.5)--(.8,1.5)--cycle;
      p3=(.5,0)--(2,0);
      p4=(-.5,0)--(-2,0);
    }
    else{
      if(sign==true){
	plus=(shift(1.2,2.4)*plus);
	moins=(shift(-1.3,2.4)*moins);
	final=plus^^moins;
      }
      p1=(.5,3)--(.5,-3);
      p2=(-.5,1.5)--(-.5,-1.5)--(-.8,-1.5)--(-.8,1.5)--cycle;
      p3=(.5,0)--(2,0);
      p4=(-.5,0)--(-2,0);
    }
    final=bounding_box^^p1^^p2^^p3^^p4^^final;
    return final;
  }
  
  picture picElement(){
    picture gen;
    filldraw(gen,shape()[0],invisible,invisible);
    draw(gen,shape()[1],drawpen+1);
    filldraw(gen,shape()[2],fillpen,drawpen);
    draw(gen,shape()[3],drawpen);
    draw(gen,shape()[4],drawpen);
    if(6<shape().length){
      filldraw(gen,shape()[5],fillpen,drawpen);
      filldraw(gen,shape()[6],fillpen,drawpen);
    }
    return gen;
  }

  void operator init(real type=0,bool sign=false,pair center=(0,0),
		     real size=1,real angle=0,pen fillpen=black,
		     pen drawpen=currentpen ... Label[] L){
    this.sign=sign;
    this.type=type;
    this.fillpen=fillpen;
    this.drawpen=drawpen;
    element.angle=angle;
    element.center=center;
    element.size=size;
    element.pic_element=picElement();
    for(int i=0;i<L.length;++i)
      if(L[i].align.dir!=0)
	element.addLabel(L[i],degrees(dir(L[i].align.dir)));
      else
	element.addLabel(L[i]);
  }

  element.getPathElement=new path[](){
    return shape();
  };

  element.connectors=new pair[](){
    //connectors
    pair[] c;
    c[0]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),W);
    c[1]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),E);
    //dot connectors
    // dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),W));
//     dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),E));
    return c;
  };
}

//capacitor
struct Capacitor{

  Element element;
  private bool help;
  private pen fillpen,drawpen;

  path[] shape(){
    path p1,p2;
    path bounding_box=(-1.2,3)--(-1.2,-3)--(1.2,-3)--(1.2,3)--cycle;
    p1=(-1,3)--(-1,-3)--(-1.1,-3)--(-1.1,3)--cycle;
    p2=(1,3)--(1,-3)--(1.1,-3)--(1.1,3)--cycle;
    return bounding_box^^p1^^p2;
  }
  
  picture picElement(){
    picture gen;
    filldraw(gen,shape()[0],invisible,invisible);
    filldraw(gen,shape()[1],fillpen,drawpen);
    filldraw(gen,shape()[2],fillpen,drawpen);
    return gen;
  }

  void operator init(pair center=(0,0),real size=1,
		     real angle=0,pen fillpen=black,
		     pen drawpen=currentpen ... Label[] L){
    this.fillpen=fillpen;
    this.drawpen=drawpen;
    this.help=help;
    element.angle=angle;
    element.center=center;
    element.size=size;
    element.pic_element=picElement();
    for(int i=0;i<L.length;++i)
      if(L[i].align.dir!=0)
	element.addLabel(L[i],degrees(dir(L[i].align.dir)));
      else
	element.addLabel(L[i]);
  }

  element.getPathElement=new path[](){
    return shape();
  };

  element.connectors=new pair[](){
    //connectors
    pair[] c;
    c[0]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),W);
    c[1]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),E);
    //dot connectors
    // dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),W));
//     dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),E));
    return c;
  };
}

//ampli op
struct AO{

  Element element;
  private bool help;
  private pen fillpen,drawpen;

  path[] shape(){
    path[] plus,moins;
    moins=texpath(Label("-",fontsize(2)));
    plus=texpath(Label("+",fontsize(1.5)));
    path p1,p2;
    //square
    p1=(0,10)--(0,-10)--(20,-10)--(20,10)--cycle;
    //triangle
    p2=(4,2)--(6,3)--(4,4)--cycle;
    p2=shift(-2)*scale(1.5)*p2;
    return shift(-10)*p1^^p2^^shift(-8,5)*moins^^
      shift(-8,-5)*plus;
  }
  
  picture picElement(){
    picture AO;
    filldraw(AO,shape()[0],fillpen,drawpen);
    draw(AO,shape()[1],drawpen);
    filldraw(AO,shape()[2],fillpen=black,drawpen);
    draw(AO,shape()[3],drawpen);
    return AO;
  }

  void operator init(pair center=(0,0),real size=1,
		     real angle=0,pen fillpen=invisible,
		     pen drawpen=currentpen ... Label[] L){
    this.fillpen=fillpen;
    this.drawpen=drawpen;
    this.help=help;
    element.angle=angle;
    element.center=center;
    element.size=size;
    element.pic_element=picElement();
    for(int i=0;i<L.length;++i)
      if(L[i].align.dir!=0)
	element.addLabel(L[i],degrees(dir(L[i].align.dir)));
      else
	element.addLabel(L[i]);
  }

  element.getPathElement=new path[](){
    return shape();
  };

  element.connectors=new pair[](){
    //points connectors
    pair c0=(-1,-.5);
    pair c1=(-1,.5);
    pair[] c;
    //connectors
    c[0]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),c0);
    c[1]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),c1);
    c[2]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),E);
    //dot connectors
    // dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),c0));
//     dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),c1));
//     dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),E));
    return c;
  };
}

//ampli op(US)
struct OA{

  Element element;
  private bool help;
  private pen fillpen,drawpen;
  private real type;
  
  path[] shape(){
    path p1;
    path[] plus,moins;
    moins=texpath(Label("-",fontsize(2)));
    plus=texpath(Label("+",fontsize(1.5)));
    path[] p2;
    //triangle
    p1=(0,10)--(0,-10)--(20,0)--cycle;
    p2=texpath(Label("$\infty$",fontsize(3)));
    if(type==0)
      return shift(-10)*p1^^shift((2,0))*p2^^shift(-8,5)*moins^^
	shift(-8,-5)*plus;
    else
      return shift(-10)*p1^^shift((2,0))*p2^^shift(-8,-5)*moins^^
	shift(-8,5)*plus;
  }
  
  picture picElement(){
    picture AO;
    filldraw(AO,shape()[0],fillpen,drawpen);
    filldraw(AO,shape()[1],fillpen=black,drawpen);
    filldraw(AO,shape()[2],fillpen=white,drawpen);
    filldraw(AO,shape()[3],fillpen=white,drawpen);
    filldraw(AO,shape()[4],fillpen=black,drawpen);
    draw(AO,shape()[5],drawpen);
    return AO;
  }

  void operator init(real type=0,pair center=(0,0),real size=1,
		     real angle=0,pen fillpen=invisible,
		     pen drawpen=currentpen ... Label[] L){
    this.type=type;
    this.fillpen=fillpen;
    this.drawpen=drawpen;
    this.help=help;
    element.angle=angle;
    element.center=center;
    element.size=size;
    element.pic_element=picElement();
    for(int i=0;i<L.length;++i)
      if(L[i].align.dir!=0)
	element.addLabel(L[i],degrees(dir(L[i].align.dir)));
      else
	element.addLabel(L[i]);
  }

  element.getPathElement=new path[](){
    return shape();
  };

  element.connectors=new pair[](){
    //points connectors
    pair c0=(-1,-.5);
    pair c1=(-1,.5);
    pair[] c;
    //connectors
    c[0]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),c0);
    c[1]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),c1);
    c[2]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),E);
    //dot connectors
    // dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),c0));
//     dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),c1));
//     dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),E));
    return c;
  };
}

struct Switch{

  Element element;
  private bool help;
  private pen fillpen,drawpen;

  path[] shape(){
    path p1,p2,p3,p4,p5;
    path bounding_box=(0,3)--(0,-3)--(8,-3)--(8,3)--cycle;
    p1=circle((8,0),0.5); 
    p2=circle((0.5,0),0.5); 
    p3=rotate(25,(0.5,0))*
      ((0.9,0.15)--(0.9,-0.15)--(8,-0.15)--(8,0.15)--cycle); 
    p4=arc((0.5,0),4,-35,45); 
    p5=rotate(-35,(0.5,0))*((4,0)--(5,0)--(4.5,-1.3)--cycle);
    return shift(-4)*(bounding_box^^p1^^p2^^p3^^p4^^p5);
  }
  
  picture picElement(){
    picture sw;
    filldraw(sw,shape()[0],invisible,invisible);
    filldraw(sw,shape()[1],fillpen=black,drawpen);
    filldraw(sw,shape()[2],fillpen=white,drawpen);
    filldraw(sw,shape()[3],fillpen=black,drawpen);
    draw(sw,shape()[4],black);
    draw(sw,shape()[5],black);
    return sw; 
  }

  void operator init(pair center=(0,0),real size=1,
		     real angle=0,pen fillpen=invisible,
		     pen drawpen=currentpen ... Label[] L){
    this.fillpen=fillpen;
    this.drawpen=drawpen;
    this.help=help;
    element.angle=angle;
    element.center=center;
    element.size=size;
    element.pic_element=picElement();
    for(int i=0;i<L.length;++i)
      if(L[i].align.dir!=0)
	element.addLabel(L[i],degrees(dir(L[i].align.dir)));
      else
	element.addLabel(L[i]);
  }

  element.getPathElement=new path[](){
    return shape();
  };

  element.connectors=new pair[](){
    //points connectors
    pair[] c;
    //connectors
    c[0]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),W);
    c[1]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),E);
    return c;
  };
}

struct Tswitch{

  Element element;
  private bool help;
  private pen fillpen,drawpen;

  path[] shape(){
    path p1,p2,p3,p4,p5,p6,p7;
    path bounding_box=(0,1)--(0,-5)--(6,-5)--(6,1)--cycle;
    p1=(2.9,-5)--(2.9,.5)--(3.1,.5)--(3.1,-5)--cycle;
    p2=rotate(90,(3,-5))*arc((3,-5),3.5,-40,40); 
    p3=circle((3,-5),.4);
    p4=circle((0,0),.4);
    p5=circle((6,0),.4);
    p6=rotate(-30,(5,-2.5))*
      (shift(4.8,-2.2)*((0,.3)--(0,-.3)--(.8,0)--cycle));
    p7=rotate(-140,(.8,-2.3))*
      (shift(.8,-2.3)*((0,.3)--(0,-.3)--(.8,0)--cycle));
    return shift(-3)*(bounding_box^^p1^^p2^^p3^^p4^^p5^^p6^^p7);
  }
  
  picture picElement(){
    picture tswitch;
    filldraw(tswitch,shape()[0],invisible,invisible);
    filldraw(tswitch,shape()[1],fillpen=black,drawpen);
    draw(tswitch,shape()[2],drawpen);
    filldraw(tswitch,shape()[3],fillpen=white,black);
    filldraw(tswitch,shape()[4],black);
    filldraw(tswitch,shape()[5],black);
    filldraw(tswitch,shape()[6],fillpen=white,black);
    filldraw(tswitch,shape()[7],fillpen=white,black);
    return tswitch; 
  }

  void operator init(pair center=(0,0),real size=1,
		     real angle=0,pen fillpen=invisible,
		     pen drawpen=currentpen ... Label[] L){
    this.fillpen=fillpen;
    this.drawpen=drawpen;
    this.help=help;
    element.angle=angle;
    element.center=center;
    element.size=size;
    element.pic_element=picElement();
    for(int i=0;i<L.length;++i)
      if(L[i].align.dir!=0)
	element.addLabel(L[i],degrees(dir(L[i].align.dir)));
      else
	element.addLabel(L[i]);
  }

  element.getPathElement=new path[](){
    return shape();
  };

  element.connectors=new pair[](){
    //points connectors
    pair c0=(-1,.69);
    pair c1=(0,-.9);
    pair c2=(1,.69);
    pair[] c;
    //connectors
    c[0]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),c0);
    c[1]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),c1);
    c[2]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),c2);
    //dot connectors
    // dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),c0));
//     dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),c1));
//     dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),E));
    return c;
  };
}

//intensity arrow
struct Intensity{

  Element element;
  private pen fillpen,drawpen;
  private real type;
  private bool intensity=true;
  private arrowhead head;
  
  path[] shape(){
    path bounding_box=(-3,1)--(-3,-1)--(3,-1)--(3,1)--cycle;
    path i=(-3,0)--(3,0);
    if(type==0)
      return (bounding_box^^i);
    else
      return rotate(180)*(bounding_box^^i);
  }
  
  picture picElement(){
    picture intensity;
    filldraw(intensity,shape()[0],invisible,invisible);
    draw(intensity,shape()[1],drawpen,MidArrow(8*element.size,arrowhead=head,
					       filltype=FillDraw(fillpen,fillpen)));
    return intensity;
  }
  
  void operator init(real type=0,pair center=(0,0),real size=1,
		     real angle=0,pen fillpen=red,
		     pen drawpen=currentpen,arrowhead head=DefaultHead
		     ... Label[] L){
    this.type=type;
    this.head=head;
    this.fillpen=fillpen;
    this.drawpen=drawpen;
    element.angle=angle;
    element.center=center;
    element.intensity=intensity;
    element.size=size;
    element.pic_element=picElement();
    for(int i=0;i<L.length;++i)
      if(L[i].align.dir!=0)
	element.addLabel(L[i],degrees(dir(L[i].align.dir)));
      else
	element.addLabel(L[i]);
  }
  
  element.getPathElement=new path[](){
    return shape();
  };
  
  element.connectors=new pair[](){
    //connectors
    pair[] c;
    c[0]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),W);
    c[1]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),E);
    //dot connectors
    // dot(element.center+
    // 	rotate(element.angle)*scale(element.size)*point(picElement(),W));
    //     dot(element.center+
    // 	rotate(element.angle)*scale(element.size)*point(picElement(),E));
    return c;
  };
}

//tension arrow
struct Tension{

  Element element;
  private pen fillpen,drawpen;
  private real type;
  private bool u=true;
  
  path[] shape(){
    path bounding_box=(-5,.5)--(-5,-.5)--(5,-.5)--(5,.5)--cycle;
    path u=(-5,0)--(5,0);
    if(type==0)
      return (bounding_box^^u);
    else
      return rotate(180)*(bounding_box^^u);
  }

  
  picture picElement(){
    picture u;
    filldraw(u,shape()[0],invisible,invisible);
    draw(u,shape()[1],drawpen,Arrow(8));
    return u;
    
  }
  
  void operator init(real type=0,pair center=(0,0),real size=1,
		     real angle=0,pen fillpen=invisible,
		     pen drawpen=currentpen ... Label[] L){
    this.type=type;
    this.fillpen=fillpen;
    this.drawpen=drawpen;
    element.angle=angle;
    element.center=center;
    element.u=u;
    element.size=size;
    element.pic_element=picElement();
    int j=0;
    if(L.length!=0)
      for(int i=0;i<L.length;++i)
      if(L[i].align.dir!=0)
	element.addLabel(L[i],degrees(dir(L[i].align.dir)));
      else
	element.addLabel(L[i]);
  }
  
  element.getPathElement=new path[](){
    return shape();
  };
  
  element.connectors=new pair[](){
    //connectors
    pair[] c;
    c[0]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),W);
    c[1]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),E);
    return c;
  };
}

struct Ground{

  Element element;
  private bool help;
  private pen fillpen,drawpen;
  private int type;

  //return paths element
  path[] shape(){
    path bounding_box=(0.5,3)--(0.5,-1)--(4,-1)--(4,3)--cycle;
    path[] p;
    p[0]=(0,0)--(4,0);
    p[1]=(2,0)--(2,3);
    for(int i=0;i<5;++i)
      p[i+2]=(i,0)--(i+.5,-1);
    if(type==0)
      return shift(-2)*(bounding_box^^p);
    else
      return rotate(180)*shift(-2)*(bounding_box^^p);
  }

  //Return a picture element
  picture picElement(){
    picture ground;
    path[] p=shape();
    filldraw(ground,p[0],invisible,invisible);
    for(int i=1;i<p.length;++i)
      draw(ground,p[i],drawpen);
    if(type==0)
      return shift(0,-3)*ground;
    else
     return shift(0,3)*ground;
  }
  
  void operator init(int type=0,pair center=(0,0),real size=1,
		     real angle=0,pen fillpen=invisible,
		     pen drawpen=currentpen ... Label[] L){
    this.type=type;
    this.fillpen=fillpen;
    this.drawpen=drawpen;
    this.help=help;
    element.angle=angle;
    element.center=center;
    element.size=size;
    element.pic_element=picElement();
    for(int i=0;i<L.length;++i)
      if(L[i].align.dir!=0)
	element.addLabel(L[i],degrees(dir(L[i].align.dir)));
      else
	element.addLabel(L[i]);
  }

  

  element.getPathElement=new path[](){
    return shape();
  };
  
  element.connectors=new pair[](){
    //points connectors
    pair c0;
    if(type==0)
      c0=(0,1);
    else
      c0=(0,-1);
    pair[] c;
    c[0]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),c0);
    c[1]=element.center+
    rotate(element.angle)*scale(element.size)*point(picElement(),c0);
    //dots connectors
    // //dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),W));
//     dot(element.center+
// 	rotate(element.angle)*scale(element.size)*point(picElement(),E));
    return c;
  };
}

Element operator cast(Resistor r){
  return r.element;
}
Element operator cast(Zresistor r){
  return r.element;
}
Element operator cast(Potentiometer p){
  return p.element;
}
Element operator cast(NPN n){
  return n.element;
}
Element operator cast(PNP p){
  return p.element;
}
Element operator cast(Diode d){
  return d.element;
}
Element operator cast(Zener z){
  return z.element;
}
Element operator cast(Coil c){
  return c.element;
}
Element operator cast(Lamp l){
  return l.element;
}
Element operator cast(IdealGen g){
  return g.element;
}
Element operator cast(Icc g){
  return g.element;
}
Element operator cast(Motor m){
  return m.element;
}
Element operator cast(Multi m){
  return m.element;
}
Element operator cast(Battery b){
  return b.element;
}
Element operator cast(Capacitor c){
  return c.element;
}
Element operator cast(AO ao){
  return ao.element;
}
Element operator cast(OA oa){
  return oa.element;
}
Element operator cast(Switch s){
  return s.element;
}
Element operator cast(Tswitch t){
  return t.element;
}
Element operator cast(Intensity i){
  return i.element;
}
Element operator cast(Tension u){
  return u.element;
}
Element operator cast(Ground g){
  return g.element;
}
