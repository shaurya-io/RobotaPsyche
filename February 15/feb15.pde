
Flowfield field;

ArrayList <Particles> p = new ArrayList<Particles>();

PImage centralImage;

void setup(){
  
  size(1000,1000);

  centralImage = loadImage("drstrange1.png");
  field = new Flowfield(10);
}

void draw(){
  
  background(0);
  for (Particles particles : p){
  particles.update();

  particles.display();
  particles.follow(field);}

  
  field.centerFlowField();
//  field.display();
  image(centralImage, width/2-centralImage.width/2, height/2-centralImage.height/2);

}  

void mousePressed(){
  for (int i=0; i<500; i++){
    p.add(new Particles(random(0,width-1), random(0,height-1)));}
}
