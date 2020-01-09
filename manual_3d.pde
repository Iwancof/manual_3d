Cube c;
Vertex player;
float ws_width = 1000;
float ws_height = 1000;

void setup() {
  size(1000, 1000);

  c = new Cube(new Vertex[] {
    new Vertex(-5,5,5),
    new Vertex(5,5,5),
    new Vertex(5,-5,5),
    new Vertex(-5,-5,5),
    new Vertex(-5,5,15),
    new Vertex(5,5,15),
    new Vertex(5,-5,15),
    new Vertex(-5,-5,15),
  });  

  player = new Vertex(0, 0, 0);

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

  p_angle += (float)dx / 100.;
  r_angle -= (float)dy / 100.;

  move = create_roll_rotation_matrix(-r_angle).Product(move);
  move = create_pitch_rotation_matrix(-p_angle).Product(move);
  move = create_yaw_rotation_matrix(-y_angle).Product(move);

  player.vec = player.vec.Plus(move);

  c.Draw();
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
