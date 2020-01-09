
class Matrix {
  public float[][] values;
  public int row, column;

  public Matrix(int a, int b) { //Contructor
    row = a;
    column = b;

    if (row <= 0 || column <= 0) {
      throw new IllegalArgumentException("Argument must be aboved 0.");
    }

    values = new float[row][column];
  }

  public void dprint() { //Print values
    for (int r = 0; r < row; r++) {
      for (int c = 0; c < column; c++) {
        print(values[r][c] + " ");
      }
      println();
    }
  }
  
  public Matrix Product(Matrix y) {//A.Product(B) <=> AB
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

  //For Coordinate
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
  
  public Matrix Copy() { //Deep copy
        Matrix ret = new Matrix(row,column);
        for(int a = 0;a < row;a++)
          for(int b = 0;b < column;b++)
            ret.values[a][b] = values[a][b];
            
        return ret;
  }
}

Matrix create_roll_rotation_matrix(float angle) {
  Matrix ret = new Matrix(3,3);
  ret.values[0][0] = 1;
  ret.values[0][1] = 0;
  ret.values[0][2] = 0;
  ret.values[1][0] = 0;
  ret.values[1][1] = cos(angle);
  ret.values[1][2] = -sin(angle);
  ret.values[2][0] = 0;
  ret.values[2][1] = sin(angle);
  ret.values[2][2] = cos(angle);
  
  return ret; 
}

Matrix create_pitch_rotation_matrix(float angle) {
  Matrix ret = new Matrix(3,3);
  ret.values[0][0] = cos(angle);
  ret.values[0][1] = 0;
  ret.values[0][2] = -sin(angle);
  ret.values[1][0] = 0;
  ret.values[1][1] = 1;
  ret.values[1][2] = 0;
  ret.values[2][0] = sin(angle);
  ret.values[2][1] = 0;
  ret.values[2][2] = cos(angle);
  
  return ret;
}

Matrix create_yaw_rotation_matrix(float angle) {
  Matrix ret = new Matrix(3,3);
  ret.values[0][0] = cos(angle);
  ret.values[0][1] = -sin(angle);
  ret.values[0][2] = 0;
  ret.values[1][0] = sin(angle);
  ret.values[1][1] = cos(angle);
  ret.values[1][2] = 0;
  ret.values[2][0] = 0;
  ret.values[2][1] = 0;
  ret.values[2][2] = 1;

  return ret;
}
