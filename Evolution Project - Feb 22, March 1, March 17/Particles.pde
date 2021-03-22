class Particles{
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  
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
    velocity.limit(dnaA.maxSpeed());
    location.add(velocity);
    acceleration.mult(0);
  }
    
  void follow(Flowfield flow) {
    PVector desired = flow.lookup(location);
    desired.mult(dnaA.maxSpeed());
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(dnaA.maxForce());
    applyForce(steer);
  }
  
  void display(){
    noStroke();
    pushMatrix();
    translate(location.x, location.y);
    rotate(velocity.heading());
    fill(0,0,0);
    ellipse(0,0,10,10);
    fill(0);
    popMatrix();
  }

PVector seek(PVector target) {
    PVector desired = PVector.sub(target, location);
    desired.normalize();
    desired.mult(dnaA.maxSpeed());
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(dnaA.maxForce());
    return steer;
  }
  
void flock(ArrayList<Particles> p) {
  // The three flocking rules
  PVector sep = separate(p);
  PVector ali = align(p);
  PVector coh = cohesion(p);

  // Arbitrary weights for these forces
  // (Try different ones!)
  sep.mult(1.5);
  ali.mult(1.0);
  coh.mult(1.0);

  // Applying all the forces
  applyForce(sep);
  applyForce(ali);
  applyForce(coh);
}

PVector align (ArrayList<Particles> p) {
  // This is an arbitrary value and could
  // vary from boid to boid.
  float neighbordist = 50;
  PVector sum = new PVector(0,0);
  int count = 0;
  for (Particles other : p) {
    float d = PVector.dist(location,other.location);
    if ((d > 0) && (d < neighbordist)) {
      sum.add(other.velocity);
      // For an average, we need to keep track of
      // how many boids are within the distance.
      count++;
    }
  }
  if (count > 0) {
    sum.div(count);
    sum.normalize();
    sum.mult(dnaA.maxSpeed());
    PVector steer = PVector.sub(sum,velocity);
    steer.limit(dnaA.maxForce());
    return steer;
  // If we don’t find any close boids,
  // the steering force is zero.
  } else {
    return new PVector(0,0);
  }
}

PVector cohesion (ArrayList<Particles> p) {
  float neighbordist = 50;
  PVector sum = new PVector(0,0);
  int count = 0;
  for (Particles other : p) {
    float d = PVector.dist(location,other.location);
    if ((d > 0) && (d < neighbordist)) {
      // Adding up all the others’ locations
      sum.add(other.location);
      count++;
    }
  }
  if (count > 0) {
    sum.div(count);
    // Here we make use of the seek() function we
    // wrote in Example 6.8.  The target
    // we seek is the average location of
    // our neighbors.
    return seek(sum); 
  } else {
    return new PVector(0,0);
  }
}

PVector separate (ArrayList<Particles> p) {
  
float desiredseparation = 20; // how close is too close.
PVector sum = new PVector();  // Start with an empty PVector.
int count = 0;  // We have to keep track of how many Vehicles are too close.

for (Particles other : p) {
float d = PVector.dist(location, other.location);
  if ((d > 0) && (d < desiredseparation)) {
    PVector diff = PVector.sub(location, other.location); 
    diff.normalize();
    // Add all the vectors together and increment the count.
    sum.add(diff); 
    count++;}
}
// now calculate the average:
if (count > 0) { // mustn't divide by zero
  sum.div(count);}
  
  sum.setMag(dnaA.maxSpeed());

  PVector steer = PVector.sub(sum,velocity);
  steer.limit(dnaA.maxForce());

  return steer;
}
}
