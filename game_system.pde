import com.google.gson.*;
import com.google.gson.stream.*;
import com.google.gson.reflect.*;
import com.google.gson.internal.*;
import com.google.gson.internal.reflect.*;
import com.google.gson.internal.bind.*;
import com.google.gson.internal.bind.util.*;
import com.google.gson.annotations.*;

import java.io.FileReader;
import java.lang.reflect.Type;

void game_initialize() {
  
  //load_notesfile("C:/Users/Rock0x3FA/OneDrive/Programs/Product/Processing/manual_3d/FireFly.json");
  List<dammy_instance> l = load_notesfile("C:\\Users\\Rock0x3FA\\OneDrive\\Programs\\Product\\Processing\\manual_3d\\FireFly.json");
  //load_notesfile("FireFly.json");
    
  nm.init_by_dammy(l);
  
  nm.init();
}

List<dammy_instance> load_notesfile(String name) {
  String json = read_file(name);
  Gson gson = new Gson();
  
  Type listType = new TypeToken<List<dammy_instance>>(){}.getType();
  List<dammy_instance> list = gson.fromJson(json,listType);
  
  return list;
  /*
  for(NoteInstance e : list) {
    e.Print();
  }
  */
}

String read_file(String str) {
  /*
  File file = new File(str);
  
  if(!file.exists()) {
    throw new IllegalArgumentException("File dose not exsist");
  }
  */
  
  String ret = "";
  
  try {  
    File file = new File(str);
    if(!file.exists()) {
      println("TEST");
    }
    FileReader fr = new FileReader(file);
    BufferedReader br = new BufferedReader(fr);
    String tmp;
    while ((tmp = br.readLine()) != null) {
      ret += tmp;
    }
    br.close();
  } catch(Exception e) {
    throw new IllegalArgumentException("File dose not exist or could not open");
  }  
  return ret;
}

void game_start_initialize() {
  player = new Vertex(0,0,0);

  r_angle = 0;
  p_angle = 0;
  y_angle = 0;
}
