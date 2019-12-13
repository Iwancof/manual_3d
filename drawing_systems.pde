

class Vertex {
  Matrix vec = new Matrix(3, 1);

  public Vertex(float x, float y, float z) {
    vec.values[0][0] = x;
    vec.values[1][0] = y;
    vec.values[2][0] = z;
  }
  public Vertex(Matrix m) {
    if(m.row != 3 || m.column != 1) {
      throw new IllegalArgumentException("Argument msut be 3*1 matrix(this is 3 dimension vector)");
    }
    vec = m;
  }

  float pos_x() {
    if (vec.z() <= 0) {
      throw new ArithmeticException("Divide by 0. Argument must be above 0.");
    }
    return vec.x() / vec.z();
  }
  float pos_y() {
    if (vec.z() <= 0) {
      throw new ArithmeticException("Divide by 0. Argument must be above 0.");
    }
    return vec.y() / vec.z();
  }
  void debug_print(Vertex p,float magni) {
    Vertex t = new Vertex(vec.Minus(p.vec));
    if(t.vec.z() <= 0) return;
    crect(t.pos_x() * magni,t.pos_y() * magni,5,5);
  }
}

class Matrix {
  public float[][] values;
  public int row, column;

  public Matrix(int a, int b) {
    row = a;
    column = b;

    if (row <= 0 || column <= 0) {
      throw new IllegalArgumentException("Argument must be aboved 0.");
    }

    values = new float[row][column];
  }

  public void dprint() {
    for (int r = 0; r < row; r++) {
      for (int c = 0; c < column; c++) {
        print(values[r][c] + " ");
      }
      println();
    }
  }

  public Matrix Product(Matrix y) {
    Matrix x = this, ret = new Matrix(x.row, y.column);

    for (int r = 0; r < x.row; r++) {
      for (int c = 0; c < y.column; c++) {
        float sum = 0;
        for (int i = 0; i < x.column; i++) {
          sum += x.values[r][i] * y.values[i][c];
        }
        ret.values[r][c] = sum;
      }
    } 
    return ret;
  }
  public Matrix Plus(Matrix y) {
    Matrix x = this, ret = new Matrix(x.row, y.column);
    if (x.row != y.row || x.column != y.column) {
      throw new IllegalArgumentException("Row and column are must be matched.");
    }
    for (int r = 0; r < x.row; r++) {
      for (int c = 0; c < x.column; c++) {
        ret.values[r][c] = x.values[r][c] + y.values[r][c];
      }
    }

    return ret;
  }
  public Matrix Multiple(float p) {
    Matrix ret = new Matrix(row, column);
    for (int r = 0; r < row; r++) {
      for (int c = 0; c < column; c++) {
        ret.values[r][c] = values[r][c] * p;
      }
    }
    return ret;
  }
  public Matrix Minus(Matrix y) {
    return this.Plus(y.Multiple(-1));
  }

  public float x() {
    if (column != 1) {
      throw new IllegalStateException("This method must be called from vector matrix.");
    }
    return values[0][0];
  }
  public float y() {
    if (column != 1) {
      throw new IllegalStateException("This method must be called from vector matrix.");
    }
    return values[1][0];
  }
  public float z() {
    if (column != 1) {
      throw new IllegalStateException("This method must be called from vector matrix.");
    }
    return values[2][0];
  }
}
