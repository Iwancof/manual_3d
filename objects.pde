int X_PLUS = 2; //0b0011
int X_MINUS = 0; //0b0000
int Y_PLUS = 6; //0b0111
int Y_MINUS = 4; //0b0100
int Z_PLUS = 10; //0b1011
int Z_MINUS = 8; //0b1000

class Square {
  Vertex[] points = new Vertex[4];
  public Square(Vertex v1, Vertex v2, Vertex v3, Vertex v4) {
    points[0] = v1;
    points[1] = v2;
    points[2] = v3;
    points[3] = v4;
    
    center = new Vertex(
      (points[0].vec.x() + points[1].vec.x() + points[2].vec.x() + points[3].vec.x()) / 4, 
      (points[0].vec.y() + points[1].vec.y() + points[2].vec.y() + points[3].vec.y()) / 4,
      (points[0].vec.z() + points[1].vec.z() + points[2].vec.z() + points[3].vec.z()) / 4
      );
  }

  void dprint() {
    drew_surface++;
    
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
    
    /*
    if(center.can_draw_by(player)) {
      crect(center.to_point(player).x,center.to_point(player).y,5,5);
    }
    */
    
  }
  
  public Vertex center;
  public Vertex normal;
  public int type;
  
}

class Cube {
  Vertex[] Points = new Vertex[8];
  Square[] Faces = new Square[6];
  Vertex center;
  
  
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
    
    Faces[0].type = Z_MINUS;
    Faces[1].type = X_MINUS;
    Faces[2].type = Z_PLUS;
    Faces[3].type = X_PLUS;
    Faces[4].type = Y_PLUS;
    Faces[5].type = Y_MINUS;
    
    center = new Vertex(
      (Faces[0].center.vec.x() + Faces[2].center.vec.x()) / 2,
      (Faces[0].center.vec.y() + Faces[2].center.vec.y()) / 2,
      (Faces[0].center.vec.z() + Faces[2].center.vec.z()) / 2
      );

    for(int i = 0;i < 6;i++) {
      Faces[i].normal = new Vertex(Faces[i].center.vec.Minus(center.vec));
    }
  }
  
  public void Draw() {
    drew_object++;
    
    for(int i = 0;i < 6;i++) {      
      boolean isDraw = false;
      Vertex cpl = new Vertex(player.vec.Minus(Faces[i].center.vec)); // Converted player coordinate
      switch((Faces[i].type & 12) >> 2) {
        case 0 : //X
          isDraw = 0 <= (cpl.vec.x() / Faces[i].normal.vec.x()) * (1 - Faces[i].type & 3);
          break;
        case 1 : //Y
          isDraw = 0 <= (cpl.vec.y() / Faces[i].normal.vec.y()) * (1 - Faces[i].type & 3);
          break;
        case 2 : //Z
          isDraw = 0 <= (cpl.vec.z() / Faces[i].normal.vec.z()) * (1 - Faces[i].type & 3);
          break;
      }
      
      if(isDraw)
        Faces[i].dprint();
    }
  }
  
  boolean isHit(float sz_x,float sz_y,float sz_z) {
    Matrix dif_x = dist_to_vis(plv_x,center);
    Matrix dif_y = dist_to_vis(plv_y,center);
    
    return isin(dif_x,sz_x,sz_y,sz_z) && isin(dif_y,sz_x,sz_y,sz_z);
  }
}
