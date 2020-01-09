void crect(float x, float y, float sx, float sy) { //Controled? Center? 
  rect(ccoord_x(x), ccoord_y(y), sx, sy);
}
void cline(float x1, float y1, float x2, float y2) {
  line(ccoord_x(x1), ccoord_y(y1), ccoord_x(x2), ccoord_y(y2));
}
void cline(Point p1, Point p2) {
  cline(p1.x, p1.y, p2.x, p2.y);
}
void cquad(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  quad(ccoord_x(x1), ccoord_y(y1), 
    ccoord_x(x2), ccoord_y(y2), 
    ccoord_x(x3), ccoord_y(y3), 
    ccoord_x(x4), ccoord_y(y4)
    );
}
float ccoord_x(float x) {
  return x + (ws_width / 2);
}
float ccoord_y(float y) {
  return ws_height - (y + (ws_height / 2));
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

Vertex[] under_player_axises = new Vertex[7];

void Initialize_rotate_matrixes() {
  r_rotate = create_roll_rotation_matrix(r_angle);
  p_rotate = create_pitch_rotation_matrix(p_angle);
  y_rotate = create_yaw_rotation_matrix(y_angle);
}

void Draw_axis() {
  //Draw x_axis;  
  
  /*

  float t = (1 - cos(r_angle) * sin(p_angle)) / (cos(r_angle) * cos(p_angle));

  //for (float t = 0; t < 10; t += 1) {
  /*
    float x = cos(p_angle) - t * sin(p_angle) * cos(r_angle);
   float y = -t * sin(r_angle);
   float z = sin(r_angle) + t * cos(p_angle) * cos(r_angle);
   *
  float x = cos(p_angle) - t * sin(p_angle);
  float y = -sin(r_angle) * sin(p_angle) - t * sin(r_angle) * cos(p_angle);
  float z = cos(r_angle) * sin(p_angle) + t * cos(r_angle) * cos(p_angle);

  println("(x,y,z) = (" + x + "," + y + "," + z + ")");
  crect(x / z, y / z, 5, 5);
  //}
  
  */

  /*
  
   for (int z = 0; z  < 10; z++) {
   for (int i = 0; i < 7; i++) {
   under_player_axises[i] = new Vertex(player.vec.Plus(new Vertex(1 * (i - 3), -1, z).vec));
   //under_player_axises[i].debug_print(player);
   //println(i + " : " + under_player_axises[i].can_draw_by(player));
   if (under_player_axises[i].can_draw_by(player) && zp_inf.can_draw_by(player))
   cline(under_player_axises[i].to_point(player), zp_inf.to_point(player));
   }
   }
   
   */
}
