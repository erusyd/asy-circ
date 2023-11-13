import ElectricalComponents;
usepackage("MajDroite");
usepackage("mathdesign","charter");
size(200);

Element r=Resistor("$R_1$");
Element r1=Resistor("Resistor");
pair A=(0,0), B=(40,0);
join(A,B,r,r1);

shipout(bbox(2mm,invisible));
