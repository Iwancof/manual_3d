void crect(float x, float y, float sx, float sy) { //Controled? Center? 
  rect(x + (ws_width / 2), ws_height - (y + (ws_height / 2)), sx, sy);
}
void cline(float x1, float y1, float x2, float y2) {
  line(x1 + (ws_width / 2), ws_height - (y1 + (ws_height / 2)), x2 + (ws_width / 2), ws_height - (y2 + (ws_height / 2)));
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

Vertex xp_inf = new Vertex(1000000, 0, 0);
Vertex xm_inf = new Vertex(-1000000, 0, 0);
Vertex yp_inf = new Vertex(0, 1000000, 0);
Vertex ym_inf = new Vertex(0, -1000000, 0);
Vertex zp_inf = new Vertex(0, 0, 1000000);
Vertex zm_inf = new Vertex(0, 0, -1000000);
Vertex origin = new Vertex(0, 0, 0);

void Initialize_rotate_matrixes() {
  r_rotate = create_roll_rotation_matrix(r_angle);
  p_rotate = create_pitch_rotation_matrix(p_angle);
  y_rotate = create_yaw_rotation_matrix(y_angle);
}

void Draw_axis() {
  /*
  Matrix visual_position_correction = new Vertex(0,-1,1).vec;  
   //move = create_roll_rotaion_matrix(-r_angle).Product(move);
   visual_position_correction = create_pitch_rotation_matrix(-p_angle).Product(visual_position_correction);
   visual_position_correction = create_yaw_rotation_matrix(-y_angle).Product(visual_position_correction);
   
   origin.vec = player.vec.Plus(visual_position_correction);
   origin.debug_print(player);
   */

  //Draw x_axis;  
  Matrix currection_base_x = new Vertex(1, 0, 0).vec;
  Matrix currection_base_y = new Vertex(0, 1, 0).vec;
  Matrix currection_base_z = new Vertex(0, 0, 1).vec;

  currection_base_x = create_roll_rotation_matrix(-r_angle).Product(currection_base_x); 
  currection_base_x = create_pitch_rotation_matrix(-p_angle).Product(currection_base_x); 
  currection_base_x = create_yaw_rotation_matrix(-y_angle).Product(currection_base_x); 

  currection_base_y = create_roll_rotation_matrix(-r_angle).Product(currection_base_y); 
  currection_base_y = create_pitch_rotation_matrix(-p_angle).Product(currection_base_y); 
  currection_base_y = create_yaw_rotation_matrix(-y_angle).Product(currection_base_y); 

  currection_base_z = create_roll_rotation_matrix(-r_angle).Product(currection_base_z); 
  currection_base_z = create_pitch_rotation_matrix(-p_angle).Product(currection_base_z); 
  currection_base_z = create_yaw_rotation_matrix(-y_angle).Product(currection_base_z); 

  float t = (currection_base_x.values[0][0] * player.vec.values[0][0] + 
    currection_base_x.values[1][0] * player.vec.values[1][0] + 
    currection_base_x.values[2][0] * player.vec.values[2][0]) /
    currection_base_x.values[2][0];

  println(t);

  //new Vertex(0,0,t).debug_print(player);

  Vertex test_point = new Vertex(0, 0, t).convert_to_vector(player);
  Vertex zp_inf_disp = zp_inf.convert_to_vector(player);
  if (test_point.can_draw() && zp_inf_disp.can_draw()) {
    cline(test_point.pos_x(), test_point.pos_y(), zp_inf_disp.pos_x(), zp_inf_disp.pos_y());
    test_point.to_disp_point().ddraw();
    zp_inf.debug_print(player);
  }
  println(zp_inf_disp.can_draw());
  /*
  new Vertex(currection_base_x).debug_print(player);
   new Vertex(currection_base_y).debug_print(player);
   new Vertex(currection_base_z).debug_print(player);
   */

  /*
    zp_inf.to_point(player).ddraw();
   zm_inf.to_point(player).ddraw();
   }
   */
}
