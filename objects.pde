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

    cquad(
      ps[0].pos_x(), ps[0].pos_y(), 
      ps[1].pos_x(), ps[1].pos_y(), 
      ps[2].pos_x(), ps[2].pos_y(), 
      ps[3].pos_x(), ps[3].pos_y()
      );
  }
}

class Cube {
  Vertex[] Points = new Vertex[8];
  Square[] Faces = new Square[6];
  
  public Cube(Vertex[] args) {
    if(args.length != 8) 
      throw new IllegalArgumentException("Args must be array which has 8 elements.");
    for(int i = 0;i < 8;i++) 
      Points[i] = args[i].Copy();
    Faces[0] = new Square(Points[0],Points[1],Points[2],Points[3]);
    Faces[1] = new Square(Points[4],Points[0],Points[3],Points[7]);
    Faces[2] = new Square(Points[5],Points[6],Points[7],Points[4]);
    Faces[3] = new Square(Points[1],Points[2],Points[6],Points[5]);
    Faces[4] = new Square(Points[4],Points[5],Points[1],Points[0]);
    Faces[5] = new Square(Points[6],Points[2],Points[3],Points[7]);    
  }
  
  public void Draw() {
    for(int i = 0;i < 6;i++) {
      Faces[i].dprint();
    }
  }
  
}
