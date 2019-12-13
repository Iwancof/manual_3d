void matrix_product_test() {
  Matrix m = new Matrix(2,2);
  m.values[0][0] = 1;
  m.values[0][1] = 2;
  m.values[1][0] = 3;
  m.values[1][1] = 4;

  Matrix n = new Matrix(2,2);
  n.values[0][0] = 5;
  n.values[0][1] = 6;
  n.values[1][0] = 7;
  n.values[1][1] = 8;
  
  m.dprint();
  n.dprint();
  
  m.product(n).dprint();
}

void matrix_from_vertex_test() {
  create_matrix_from_vertex(v[0]).dprint();
}

void matrix_product_from_vertex_test() {
  Matrix m = new Matrix(3,3);
  int t = 1;
  for(int i = 0;i < 3;i++) {
    for(int j = 0;j < 3;j++) {
      m.values[i][j] = t++;
    }
  }
  
  Vertex v = new Vertex(1,2,3);
  //println(create_matrix_from_vertex(v).column);
  m.product(create_matrix_from_vertex(v)).dprint();
}
  
  
