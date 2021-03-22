class Flowfield {

  PVector[][] field;
  int rows, cols;
  int resolution; 


  Flowfield(int r) {
    resolution = r;
    rows = height/resolution;
    cols = width/resolution;


  field = new PVector[cols][rows];
  centerFlowField();
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
        ellipse(f.x, f.y, 5, 5); 
        popMatrix();
      }
    }
  }
}
