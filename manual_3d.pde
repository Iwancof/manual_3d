Vertex[] v = new Vertex[100];
Vertex player;
float ws_width = 1000;
float ws_height = 1000;


void setup() {
  size(1000,1000);
  
  for(int i = 0;i < 100;i++) {
    v[i] = new Vertex(random(50) - 25,random(50) - 25,random(50) - 25);
  }
  player = new Vertex(0,0,0);
  
  //matrix_operator_test();
}

void draw() {
  background(204);
  
  //move
  if(key_press[0]) player.vec.values[2][0] += 0.1;
  if(key_press[1]) player.vec.values[0][0] -= 0.5;
  if(key_press[2]) player.vec.values[2][0] -= 0.1;
  if(key_press[3]) player.vec.values[0][0] += 0.5;
  if(key_press[4]) player.vec.values[1][0] += 0.7;
  if(key_press[5]) player.vec.values[1][0] -= 0.7;
    
  //player.vec.values[0][0] += 0.1;
  for(int i = 0;i < 100;i++) {
    v[i].debug_print(player,1);
  }  
}

boolean[] key_press = new boolean[6];

void keyPressed() {
  if(key == 'w') key_press[0] = true;
  if(key == 'a') key_press[1] = true;  
  if(key == 's') key_press[2] = true;
  if(key == 'd') key_press[3] = true;
  if(key == ' ') key_press[4] = true;
  if(keyCode == SHIFT) key_press[5] = true; 
}



void keyReleased() {
  if(key == 'w') key_press[0] = false;
  if(key == 'a') key_press[1] = false;  
  if(key == 's') key_press[2] = false;
  if(key == 'd') key_press[3] = false;
  if(key == ' ') key_press[4] = false;
  if(keyCode == SHIFT) key_press[5] = false; 
}
