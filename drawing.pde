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
void ctext(String text, float x, float y) {
  text(text, ccoord_x(x), ccoord_y(y));
}

void Drawing_initialize() {
  drew_object = 0;
  drew_surface = 0;
  
  Initialize_rotate_matrixes();
  Initialize_gaze_vertexes();
  Draw_axis();
}

float p_angle = 0;
float y_angle = 0;
float r_angle = 0;

Matrix r_rotate;
Matrix p_rotate;
Matrix y_rotate;
Matrix r_rotate_inv;
Matrix p_rotate_inv;
Matrix y_rotate_inv;
Vertex plv_x;
Vertex plv_y;
Vertex plv_z;

Vertex[] under_player_axises = new Vertex[7];

void Initialize_rotate_matrixes() {
  r_rotate = create_roll_rotation_matrix(r_angle);
  p_rotate = create_pitch_rotation_matrix(p_angle);
  y_rotate = create_yaw_rotation_matrix(y_angle);

  r_rotate_inv = create_roll_rotation_matrix(-r_angle);
  p_rotate_inv = create_pitch_rotation_matrix(-p_angle);
  y_rotate_inv = create_yaw_rotation_matrix(-y_angle);
}

void Initialize_gaze_vertexes() {
  plv_x = new Vertex(1, 0, 0);

  plv_x.vec = r_rotate_inv.Product(plv_x.vec);
  plv_x.vec = p_rotate_inv.Product(plv_x.vec);
  plv_x.vec = y_rotate_inv.Product(plv_x.vec);

  plv_y = new Vertex(0, 1, 0);

  plv_y.vec = r_rotate_inv.Product(plv_y.vec);
  plv_y.vec = p_rotate_inv.Product(plv_y.vec);
  plv_y.vec = y_rotate_inv.Product(plv_y.vec);

  plv_z = new Vertex(0, 0, 1);

  plv_z.vec = r_rotate_inv.Product(plv_z.vec);
  plv_z.vec = p_rotate_inv.Product(plv_z.vec);
  plv_z.vec = y_rotate_inv.Product(plv_z.vec);
}

void Draw_axis() { //軸、いらなくね？


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
   /  /println(i + " : " + under_player_axises[i].can_draw_by(player));
   if (under_player_axises[i].can_draw_by(player) && zp_inf.can_draw_by(player))
   cline(under_player_axises[i].to_point(player), zp_inf.to_point(player));
   }
   }
   
   */
}

void Draw_score() {
  fill(0);
  textSize(50);
  text("Score : " + score + "!!", 600, 35);
}


NoteInstance title_bar;
Vertex title_string_place;

void Draw_title() {
  GameStarted = !title_bar.entry;
  if(GameStarted) game_start_initialize();
  title_bar.Draw();
  if (!title_string_place.can_draw_by(player)) return;

  Point p = title_string_place.to_point(player);

  fill(color(100, 200, 100));
  textSize(90);
  ctext("-start-", p.x, p.y);
  //crect(p.x,p.y,5,5);
}

boolean GameFinished = false;

void ending() {
  minim.stop();
  
  fill(color(0,200,100));
  textSize(80);  
  text("Your score is " + score,200,200);
  
  fill(color(100,100,200));
  textSize(50);
  text("If you play again,Press any key",180,300); 
}


void draw_player_details() {
  fill(color(0,0,0));
  textSize(20);
  text("Coordinate:(x,y,z)=(" + player.vec.x() + "," + player.vec.y() + "," + player.vec.z() + ").",0,20);
  text("Angle:roll,pitch,yaw = " + r_angle + "," + p_angle + "," + y_angle + ".",0,40);
  text("Velocity:" + velocity + ".",0,60);
  text("Vertual mouse pointer:(x,y) = (" + pseu_x + "," + pseu_y + ").Mouse move:(x,y) = " + dif_x + "," + dif_y + ").",0,80);
  text("Frame rate:" + frameRate + ".",0,100);
  text("Drawing counter,Object: " + drew_object + ",Surface : " + drew_surface + ".",0,120);
}
