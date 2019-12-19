Vertex[] v = new Vertex[8];
Square s;
Vertex player;
float ws_width = 1000;
float ws_height = 1000;


void setup() {
  size(1000, 1000);

  s = new Square(
    new Vertex(0, 0, 0), 
    new Vertex(10, 0, 0), 
    new Vertex(10, 10, 0), 
    new Vertex(0, 10, 0)
    );

  v[0] = new Vertex(0, 0, 0);
   v[1] = new Vertex(0, 0, 10);
   v[2] = new Vertex(0, 10, 0);
   v[3] = new Vertex(0, 10, 10);
   v[4] = new Vertex(10, 0, 0);
   v[5] = new Vertex(10, 0, 10);
   v[6] = new Vertex(10, 10, 0);
   v[7] = new Vertex(10, 10, 10);

  /*
  for(int i = 0;i < 100;i++) {
   v[i] = new Vertex(random(50) - 25,random(50) - 25,random(20));
   }
   */

  player = new Vertex(0, 0, 0);

  //matrix_operator_test();

  pmx = mouseX;
  pmy = mouseY;
}

int pmx, pmy;

void draw() {
  background(204);
  Drawing_initialize();

  //move
  Matrix move = new Matrix(3, 1);

  if (key_press[0]) move.values[2][0] += 0.1;
  if (key_press[1]) move.values[0][0] -= 0.5;
  if (key_press[2]) move.values[2][0] -= 0.1;
  if (key_press[3]) move.values[0][0] += 0.5;
  if (key_press[4]) player.vec.values[1][0] += 0.7;
  if (key_press[5]) player.vec.values[1][0] -= 0.7;
  if (key_press[6]) r_angle += 0.01;
  if (key_press[7]) p_angle += 0.01; 
  if (key_press[8]) y_angle += 0.01;

  int dx = mouseX - pmx;
  int dy = mouseY - pmy;
  pmx = mouseX;
  pmy = mouseY;

  //println("(x,y) = (" + dx + "," + dy + ")");

  p_angle += (float)dx / 100.;
  r_angle -= (float)dy / 100.;

  move = create_roll_rotation_matrix(-r_angle).Product(move);
  move = create_pitch_rotation_matrix(-p_angle).Product(move);
  move = create_yaw_rotation_matrix(-y_angle).Product(move);

  player.vec = player.vec.Plus(move);

  //player.vec.values[0][0] += 0.1;

  for (int i = 0; i < 8; i++) {
    v[i].debug_print(player);
  }
  
  
  //s.dprint();

  //inf.debug_print(player, r_angle, p_angle, y_angle);
}

boolean[] key_press = new boolean[9];

void keyPressed() {
  if (key == 'w') key_press[0] = true;
  if (key == 'a') key_press[1] = true;  
  if (key == 's') key_press[2] = true;
  if (key == 'd') key_press[3] = true;
  if (key == ' ') key_press[4] = true;
  if (keyCode == SHIFT) key_press[5] = true; 
  if (key == 'r') key_press[6] = true;
  if (key == 'p') key_press[7] = true;
  if (key == 'y') key_press[8] = true;
  if (key == 'i') {
    r_angle = 0;
    p_angle = 0;
    y_angle = 0;
  };
}



void keyReleased() {
  if (key == 'w') key_press[0] = false;
  if (key == 'a') key_press[1] = false;  
  if (key == 's') key_press[2] = false;
  if (key == 'd') key_press[3] = false;
  if (key == ' ') key_press[4] = false;
  if (keyCode == SHIFT) key_press[5] = false; 
  if (key == 'r') key_press[6] = false;
  if (key == 'p') key_press[7] = false;
  if (key == 'y') key_press[8] = false;
}
