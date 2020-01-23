import java.awt.AWTException;
import java.awt.Robot;
import java.awt.Frame;
import processing.awt.PSurfaceAWT;

boolean GameStarted = false;

NoteMatrix nm = new NoteMatrix();
Vertex player;
Vertex goal = new Vertex(3,3,3);

float ws_width = 1000;
float ws_height = 1000;

int pseu_x, pseu_y;
int cent_x = (int)(ws_width / 2);
int cent_y = (int)(ws_height / 2);
int dif_x, dif_y;
int scr_x, scr_y;

Robot robot;

float velocity;
float end_cz;

int drew_object;
int drew_surface;

void setup() {
  system_initialize();
  sound_initialize();
  
  game_initialize();
    
  size(1000, 1000);
  //fullScreen();
  ws_width = width;
  ws_height = height;
  
  cent_x = (int)(ws_width / 2);
  cent_y = (int)(ws_height / 2);
  
  pseu_x = cent_x;
  pseu_y = cent_y;

  try {
    robot = new Robot();
  }
  catch (AWTException e) {
    e.printStackTrace();
  }
  noCursor();
  
  scr_x = getFrame().getX() + 3; 
  scr_y = getFrame().getY() + 32;
  
  player = new Vertex(0, 0, 0);

  pmx = mouseX;
  pmy = mouseY;
  
  nm.SortNotes();
  
  //sound_test();
  
  title_bar = new NoteInstance(-3,9,6,6,4,1,color(200,100,50));
  title_bar.non_invis = true;
  title_bar.hit_color = color(255,0,0);
  title_bar.f = new Disap(title_bar);
  
  title_string_place = title_bar.cube.center;
  title_string_place.vec = title_string_place.vec.Plus(new Vertex(-3,0,0).vec);
  
  score = 0;
  p_angle = 0;
  y_angle = 0;
  r_angle = 0;
  
  velocity = 0.1;
}

int pmx, pmy;

void draw() {
  background(204);
  Drawing_initialize();

  Matrix move = key_processes();

  player.vec = player.vec.Plus(move);

  
  if(!GameStarted) {
    Draw_title();
    last();
    return;
  }
  if(GameFinished) {
    ending();
    last();
    return;
  }
  
  player.vec.values[2][0] += velocity;
  if(end_cz - player.vec.z() < 5) {
    velocity *= 0.95;
  }
  
  Draw_score();

  nm.Draw();  
  
  last();
}

void last() {
  stroke(color(255,0,0));
  
  cline(10,0,-10,0);
  cline(0,10,0,-10);
  stroke(color(0,0,0));
  
  draw_player_details();
}


boolean[] key_press = new boolean[9];

void keyPressed() {
  if(GameFinished) return;
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
  if(key == 'k') {
  }
}



void keyReleased() {
  if(GameFinished) {
    GameFinished = false;
    setup();    
    GameStarted = false;
  }
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

void mouseMoved(){
  if(focused && !GameFinished) {
    resetMousePosition();
  }
}

void mouseDragged(){
  if(focused && !GameFinished) {
    resetMousePosition();
  }
}

void resetMousePosition() {
  dif_x = mouseX - cent_x;
  dif_y = mouseY - cent_y;
  
  robot.mouseMove(scr_x + cent_x,scr_y + cent_y);
  //robot.mouseMove(this.getLocationOnScreen().x + cent_x,this.getLocaltionOnScreent().y + cent_y);
  
  pseu_x += dif_x;
  pseu_y += dif_y;
  
  //println(dif_x + " : " + dif_y);
  //println(scr_x + " : " + scr_y);
}

Frame getFrame() {
  PSurfaceAWT.SmoothCanvas canvas;
  canvas = (PSurfaceAWT.SmoothCanvas)getSurface().getNative();
  return canvas.getFrame();
}

Matrix key_processes() {
  Matrix move = new Matrix(3, 1);

  p_angle += (float)dif_x / 200.;
  r_angle -= (float)dif_y / 200.;

   
  if(!GameStarted) {
    if (key_press[0]) move.values[2][0] += 0.1;
    if (key_press[1]) move.values[0][0] -= 0.5;
    if (key_press[2]) move.values[2][0] -= 0.1;
    if (key_press[3]) move.values[0][0] += 0.5;
    if (key_press[4]) player.vec.values[1][0] += 0.7;
    if (key_press[5]) player.vec.values[1][0] -= 0.7;
  }
  if (key_press[6]) r_angle += 0.01;
  if (key_press[7]) p_angle += 0.01; 
  if (key_press[8]) y_angle += 0.01;
  
  move = create_pitch_rotation_matrix(-p_angle).Product(move);
  move = create_yaw_rotation_matrix(-y_angle).Product(move);
  
  return move;
}
