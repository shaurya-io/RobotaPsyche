
Flowfield field;
DNAA dnaA;
DNAB dnaB;
ArrayList <Particles> plist = new ArrayList<Particles>();

PImage centralImage;

void setup(){
  
  size(1000,1000);


  field = new Flowfield(20);
  dnaA = new DNAA();
  dnaB = new DNAB();
}

void draw(){
  
  background(255);
  for (Particles p : plist){
  p.update();
  p.display();
  p.follow(field);
  p.flock(plist);}  
  field.followMouse(); 
  field.display();


}  

void mousePressed(){
  for (int i=0; i<100; i++){
    
    plist.add(new Particles(random(0,width-1), random(0,height-1)));}
}
