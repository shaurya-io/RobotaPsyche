class Particles{
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  float maxSpeed = 50;
  float maxForce = 3;

  

  
  Particles(float x, float y){
    location = new PVector(x,y);
    velocity = new PVector(0,0);
    acceleration = new PVector(1,0);
  }
  
  void applyForce(PVector force){
    acceleration.add(force);
  }
  
  void update(){
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
    acceleration.mult(0);
  }
    
  void follow(Flowfield flow) {
    PVector desired = flow.lookup(location);
    desired.mult(maxSpeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    applyForce(steer);
  }
  
  void display(){
    noStroke();
    fill(62, 59, 144);
    pushMatrix();
    translate(location.x, location.y);
    rotate(velocity.heading());
    fill(255,random(80,225),0);
    ellipse(0,0,5,5);
    popMatrix();
  }

}
