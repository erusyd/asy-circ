/*
  Developped by Christophe CASSEAU
  April 2010
 */
import Element;
struct Circuit{

  Element[] e;
  
  void operator init(...Element[] e){
    this.e=e;
  }

  Element serie(real decal=20){
    pair c;
    pair suiv,prec;
    Element element;
    picture tmp,pic;
    pair con0,con1;
    for(int i=0;i<e.length;++i){
      label(e[i].pic_element,e[i].labe,e[i].posL);
      add(tmp,shift(decal*i)*rotate(e[i].angle)*scale(e[i].size)*e[i].pic_element);
      
      if(i<e.length-1)
	draw(tmp,shift(decal*i)*e[i].connect(1)--
	     shift(decal*(i+1))*e[i+1].connect(0));
    }
    add(pic,shift(-(min(tmp).x+max(tmp).x)/2)*tmp);
    con0=shift(-(min(tmp).x+max(tmp).x)/2)*e[0].connect(0);
    con1=shift(-(min(tmp).x+max(tmp).x)/2)*
      shift(decal*(e.length-1))*e[e.length-1].connect(1);
    //connexions
    //element.setPicElement(shift(0,-con0.y)*pic);
    element.setPicElement(pic);
    element.connectors=new pair[](){
      //points connectors
      pair[] c;
      c[0]=element.center+
      rotate(element.angle)*scale(element.size)*con0;
      c[1]=element.center+
      rotate(element.angle)*scale(element.size)*con1;
      return c;
    };
    return element;
  }//end serie

  Element parallel(int decal=10, real hc=0,int branch=1){
    pair c;
    pair cmax=(0,0);
    Element element;
    picture tmp,pic;
    pair[] con0,con1;
    for(int i=0;i<e.length;++i){
      label(e[i].pic_element,e[i].labe,e[i].posL);
      add(tmp,shift(0,decal*i)*scale(e[i].size)*e[i].pic_element);
      pair B=shift(0,decal*i)*e[i].connect(1);
      if(B.x>cmax.x)
	cmax=B;
    }
    //tracé du circuit parallèle
    pair[] Af,Bf;
    for(int i=0;i<e.length;++i){
      pair Ai=shift(0,decal*i)*e[i].connect(0);
      pair Bi=shift(0,decal*i)*e[i].connect(1);
      Bf[i]=((Bi.x+(cmax.x-Bi.x)),Bi.y)+decal/3;
      Af[i]=((Ai.x+(-cmax.x-Ai.x)),Ai.y)-decal/3;
      if(e[i].u!=true){
	draw(tmp,Bi--Bf[i]);
	draw(tmp,Ai--Af[i]);
      }
      //repérage des connecteurs des différents éléments
      con0[i]=shift(-(min(tmp).x+max(tmp).x)/2)*shift(0,decal*i)*e[i].connect(0);
      con1[i]=shift(-(min(tmp).x+max(tmp).x)/2)*shift(0,decal*i)*e[i].connect(1);
    }
    draw(tmp,Af[0]--Af[Af.length-1]);
    draw(tmp,Bf[0]--Bf[Bf.length-1]);
    //
    add(pic,shift(-(min(tmp).x+max(tmp).x)/2)*tmp);
    //connexions
    if(branch>-1 && branch<=con0.length)
      element.setPicElement(shift(0,-(hc+con0[branch-1].y))*pic);
    else
      element.setPicElement(shift(0,-(hc+con0[0].y))*pic);
    element.connectors=new pair[](){
      //points connectors
      pair[] c;
      if(branch>-1 && branch<=con0.length){
	c[0]=element.center+rotate(element.angle)*scale(element.size)*
	  ((Af[branch-1].x,hc+con0[branch-1].y)-(0,hc+con0[branch-1].y));
	c[1]=element.center+rotate(element.angle)*scale(element.size)*
	  ((Bf[branch-1].x,hc+con1[branch-1].y)-(0,hc+con1[branch-1].y));
      }
      else{
	c[0]=element.center+rotate(element.angle)*scale(element.size)*
	  ((Af[0].x,hc+con0[0].y)-(0,hc+con0[0].y));
	c[1]=element.center+rotate(element.angle)*scale(element.size)*
	  ((Bf[0].x,hc+con1[0].y)-(0,hc+con1[0].y));
      }
      return c;
    };
    return element;
  }//end parallel
}//end Circuit


