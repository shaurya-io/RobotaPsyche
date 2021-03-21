vehicle car;

PImage vehicleImage;

void setup(){
  
  size(1000,1000);
  car = new vehicle();
  vehicleImage = loadImage("car.png");
}

void draw(){
  background(255);
  car.update();
  car.edgeCheck();
  car.display();

if (keyPressed == true){
  if (keyCode == RIGHT){
    car.acceleration.x = 0.5;}
    
  if (keyCode == LEFT){
    car.acceleration.x = -0.5;}
    
  if (keyCode == UP){
    car.acceleration.y = -0.5;}
    
  if (keyCode == DOWN){
    car.acceleration.y = 0.5;}
}

}
