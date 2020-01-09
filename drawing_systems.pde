class Vertex {
  Matrix vec = new Matrix(3, 1);

  public Vertex(float x, float y, float z) { //Normal Constructor
    vec.values[0][0] = x;
    vec.values[1][0] = y;
    vec.values[2][0] = z;
  }
  
  public Vertex(Matrix m) { //Coordinate Constructor
    if (m.row != 3 || m.column != 1) {
      throw new IllegalArgumentException("Argument msut be 3*1 matrix(this is 3 dimension vector)");
    }
    vec = m;
  }
  public Vertex Copy() {
    return new Vertex(vec.Copy());
  }

  //Convert to display coordinate
  float pos_x() {
    if (vec.z() <= 0) {
      throw new ArithmeticException("Divide by 0. Argument must be above 0.");
    }
    return vec.x() / (vec.z() / 300);
  }
  float pos_y() {
    if (vec.z() <= 0) {
      throw new ArithmeticException("Divide by 0. Argument must be above 0.");
    }
    return vec.y() / (vec.z() / 300);
  }
  
  ////Draw rectangle which size is 5 * 5  
  void debug_print(Vertex pl) {
    Vertex t = convert_to_vector(pl);

    if (!t.can_draw()) return;

    crect(t.pos_x(), t.pos_y(), 5, 5);
  }
  
  //Convert axis for player and convert to display coordinate
  Point to_point(Vertex pl) {
    Vertex t = convert_to_vector(pl);
    return new Point(t.pos_x(),t.pos_y());
  }
  //Convert to display coodinate only
  Point to_disp_point() {
    return new Point(pos_x(),pos_y());
  }

    
  boolean can_draw() {
    return vec.z() > 0;
  }
  boolean can_draw_by(Vertex v) {
    return convert_to_vector(v).can_draw();
  }
  
  Vertex convert_to_vector(Vertex pl) {
    Vertex t = new Vertex(vec.Minus(pl.vec));
    //visual face is on z = 1. this is currection.
    //t.vec.values[0][0] -= 1; 
    //t.vec.values[1][0] -= 1;
    //t.vec.values[2][0] -= 1;

    //Matrix r = create_roll_rotation_matrix(roll_angle);
    //Matrix p = create_pitch_rotation_matrix(pitch_angle);
    //Matrix y = create_yaw_rotation_matrix(yaw_angle);

    t.vec = p_rotate.Product(t.vec);
    t.vec = r_rotate.Product(t.vec);
    t.vec = y_rotate.Product(t.vec);

    //t.vec.values[0][0] += 1;
    //t.vec.values[1][0] += 1;
    //t.vec.values[2][0] += 1;

    return t;
  }
}

class Point {
  float x,y;
  public Point(float x,float y) {
    this.x = x;
    this.y = y;
  }
  public void ddraw() {
    crect(x, y, 5, 5);
  }
}
    
