class Flowfield {

  PVector[][] field;
  int rows, cols;
  int resolution; 


  Flowfield(int r) {
    resolution = r;
    rows = height/resolution;
    cols = width/resolution;


    field = new PVector[cols][rows];
    //centerFlowField();
    //followMouse();
  }

  void centerFlowField() {

    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        PVector v = new PVector(map(i, 0, cols, 1, -1), map(j, 0, rows, 1, -1));
        v.normalize();       
        field[i][j] = v;
      }
    }
  }

  void followMouse() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        PVector mouse = new PVector(mouseX, mouseY);
        PVector vehiclelocation = new PVector(i*resolution, j*resolution);
        PVector v = PVector.sub(mouse, vehiclelocation);
        v.normalize();
        field[i][j] = v;
      }
    }
  }

  void perlinFlowField() {

    float xoff = 0.01;//random();
    for (int i = 0; i < cols; i++) {
      float yoff = 0.01; //random(30);
      for (int j = 0; j < rows; j++) {


        float theta = map(noise(xoff, yoff), 0, 1, 0, TWO_PI);

        // Convert the angle (polar coordinate) to Cartesian coordinates
        field[i][j] = new PVector(cos(theta), sin(theta));

        // Move to neighboring noise in Y axis
        yoff += 0.1;
      }

      // Move to neighboring noise in X axis
      xoff += 0.1;
    }
  }

  PVector lookup(PVector lookup) {

    int column = int(constrain(lookup.x/resolution, 0, cols-1));
    int row = int(constrain(lookup.y/resolution, 0, rows-1));
    return field[column][row].copy();
  }


  void display() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        print("col " + i + " row " + j + "  ");
        println(i*resolution, j*resolution, field[i][j].x, field[i][j].y);
        pushMatrix();

        translate(i*resolution, j*resolution);
        PVector f = field[i][j].copy();
        f.mult(resolution);
        line(0, 0, f.x, f.y);
        ellipse(f.x, f.y, 2, 2); 
        popMatrix();
      }
    }
  }
}
