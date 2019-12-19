class Vertex {
  Matrix vec = new Matrix(3, 1);

  public Vertex(float x, float y, float z) {
    vec.values[0][0] = x;
    vec.values[1][0] = y;
    vec.values[2][0] = z;
  }
  public Vertex(Matrix m) {
    if (m.row != 3 || m.column != 1) {
      throw new IllegalArgumentException("Argument msut be 3*1 matrix(this is 3 dimension vector)");
    }
    vec = m;
  }

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
  
  void debug_print(Vertex pl) {
    Vertex t = convert_to_vector(pl);

    if (!t.can_draw()) return;

    crect(t.pos_x(), t.pos_y(), 5, 5);
  }
  
  Point to_point(Vertex pl) {
    Vertex t = convert_to_vector(pl);
    return new Point(t.pos_x(),t.pos_y());
  }
  Point to_disp_point() {
    return new Point(pos_x(),pos_y());
  }
    
  boolean can_draw() {
    return vec.z() > 0;
  }
  
  Vertex convert_to_vector(Vertex pl) {
    Vertex t = new Vertex(vec.Minus(pl.vec));
    t.vec.values[0][0] -= 1;
    t.vec.values[1][0] -= 1;
    t.vec.values[2][0] -= 1;

    //Matrix r = create_roll_rotation_matrix(roll_angle);
    //Matrix p = create_pitch_rotation_matrix(pitch_angle);
    //Matrix y = create_yaw_rotation_matrix(yaw_angle);

    t.vec = p_rotate.Product(t.vec);
    t.vec = r_rotate.Product(t.vec);
    t.vec = y_rotate.Product(t.vec);

    t.vec.values[0][0] += 1;
    t.vec.values[1][0] += 1;
    t.vec.values[2][0] += 1;

    return t;
  }
}

class Square {
  Vertex[] points = new Vertex[4];
  public Square(Vertex v1, Vertex v2, Vertex v3, Vertex v4) {
    points[0] = v1;
    points[1] = v2;
    points[2] = v3;
    points[3] = v4;
  }

  void dprint() {
    Vertex[] ps = new Vertex[4];
    for (int i = 0; i < 4; i++) {
      ps[i] = points[i].convert_to_vector(player);
      if (!ps[i].can_draw()) return;
    }

    quad(
      ps[0].pos_x(), ps[0].pos_y(), 
      ps[1].pos_x(), ps[1].pos_y(), 
      ps[2].pos_x(), ps[2].pos_y(), 
      ps[3].pos_x(), ps[3].pos_y()
      );
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
    
