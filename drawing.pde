void crect(float x,float y,float sx,float sy) {
  rect(x + (ws_width / 2),ws_height - (y + (ws_height / 2)),sx,sy);
}

void Drawing_initialize() {
  Initialize_rotate_matrixes();
  Draw_axis();
}

float p_angle = 0;
float y_angle = 0;
float r_angle = 0;

Matrix r_rotate;
Matrix p_rotate;
Matrix y_rotate;

Vertex xp_inf = new Vertex(1000000,0,0);
Vertex xm_inf = new Vertex(-1000000,0,0);
Vertex yp_inf = new Vertex(0,1000000,0);
Vertex ym_inf = new Vertex(0,-1000000,0);
Vertex zp_inf = new Vertex(0,0,1000000);
Vertex zm_inf = new Vertex(0,0,-1000000);
Vertex origin;

void Initialize_rotate_matrixes() {
  r_rotate = create_roll_rotation_matrix(r_angle);
  p_rotate = create_pitch_rotation_matrix(p_angle);
  y_rotate = create_yaw_rotation_matrix(y_angle);  
}

void Draw_axis() {
  origin = new Vertex(0,0,0);
  origin.vec = player.vec.Plus(new Vertex(0,-5,1).vec);
  //move = create_roll_rotaion_matrix(-r_angle).Product(move);
  origin.vec = create_pitch_rotation_matrix(-p_angle).Product(origin.vec);
  origin.vec = create_yaw_rotation_matrix(-y_angle).Product(origin.vec);
    
  //Draw x_axis;
  
  origin.debug_print(player);
  
  /*
    zp_inf.to_point(player).ddraw();
    zm_inf.to_point(player).ddraw();
  }
  */

}
  
  
