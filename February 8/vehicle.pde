class vehicle{
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  

  

  
  vehicle(){
    location = new PVector(width/2, height/2);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
  }
  
  void update(){
    velocity.limit(5);
    location.add(velocity);
    velocity.add(acceleration);
    acceleration.mult(0);
  }
  
  void display(){
    stroke(0);
    fill(62, 59, 144);
    
    pushMatrix();
    translate(location.x, location.y);
    rotate(velocity.heading());
    image(vehicleImage,0,0);
    popMatrix();
  }
  
  void edgeCheck(){
    if(location.x>width){
      location.x = 0;}
    if(location.x<0){
      location.x = width;}
    if(location.y>height){
      location.y = 0;}
    if(location.y<0){
      location.y = height;}
  }
}
