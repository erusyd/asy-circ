import ElectricalComponents;
size(200);

pair A=(20,60), B=(120,120);
dot("A",A,blue+6);
dot("B",B,blue+6);
//a grid for debug
addGrid(200,200,gray+3);
//contour
shipout(bbox(2mm,invisible));
