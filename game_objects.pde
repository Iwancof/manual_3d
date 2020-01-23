import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Collections;
import java.util.Comparator;

int score = 0;
float hand_dist = 10;

class NoteInstance {
  float sz_x,sz_y,sz_z;
  float cn_x,cn_y,cn_z; //左手前上
  color cl = color(255,0,0);
  boolean entry = true;
  boolean non_invis = false;
  color hit_color;
  color range_color = color(200,100,50);
  FunctionObjectClass f;
  
  Cube cube;
    
  public NoteInstance(float cn_x,float cn_y,float cn_z,float sz_x,float sz_y,float sz_z,color cl) {
    this.sz_x = sz_x;
    this.sz_y = sz_y;
    this.sz_z = sz_z;
    
    this.cn_x = cn_x;
    this.cn_y = cn_y;
    this.cn_z = cn_z;
    
    this.cl = cl;
    
    init();
  }
  
  void init() {
    cube = new Cube(
      new Vertex[] {
        new Vertex(cn_x,       cn_y,       cn_z),
        new Vertex(cn_x + sz_x,cn_y,       cn_z),
        new Vertex(cn_x + sz_x,cn_y - sz_y,cn_z),
        new Vertex(cn_x,       cn_y - sz_y,cn_z),

        new Vertex(cn_x,       cn_y,       cn_z + sz_z),
        new Vertex(cn_x + sz_x,cn_y,       cn_z + sz_z),
        new Vertex(cn_x + sz_x,cn_y - sz_y,cn_z + sz_z),
        new Vertex(cn_x,       cn_y - sz_y,cn_z + sz_z)
      }
      );
      f = new NoOpe();
  }
    
  
  void Draw() {
    if(!entry)
      return;
    
    if(cube.isHit(sz_x,sz_y,sz_z) && p_dist(cube.center) < hand_dist) {
    //if(cube.isHit(sz_x,sz_y,sz_z) && cube.center.vec.z() - player.vec.z() < 5) {
    
      if(f.func()) return;    
            
      if(!non_invis) {
        score++;
        entry = false;
        return;
      }
      fill(hit_color);
    } else {
      if(p_dist(cube.center) < hand_dist)
        fill(range_color);      
      else fill(cl);
    }
    
    cube.Draw();
  }
  void Print() {
    System.out.printf("On (%f,%f,%f),size = %f,%f,%f\n",cn_x,cn_y,cn_z,sz_x,sz_y,sz_z);
  }
}

NoteInstance CreateNoteInstance(dammy_instance d) {
  NoteInstance ni = new NoteInstance(d.cn_x,d.cn_y,d.cn_z,d.sz_x,d.sz_y,d.sz_z,color(d.r,d.g,d.b));
  if(d.end_flag){
    ni.f = new End();
    end_cz = d.cn_z;
    ni.non_invis = true; 
    ni.hit_color = color(150,200,0);
  } else {
    ni.f = new NoOpe();
  }
  return ni;
}


class NoteMatrix {
  List<NoteInstance> Notes;// = new ArrayList<NoteInstance>();
  
  public NoteMatrix() {
    Notes = new ArrayList<NoteInstance>();
  }
  public void init() {
    Notes.get(0).init();
  }
  
  public void SortNotes() {
    //println(Notes);
    
    Collections.sort(
      Notes,
      new Comparator<NoteInstance>() {
        @Override
        public int compare(NoteInstance x,NoteInstance y) {
          return (int)(y.cn_z - x.cn_z);
        }
      }
      );
    //println(Notes);
  }
 
  int min_index = 0;
  
  void Draw() {
    for(int i = min_index;(i < Notes.size());i++) {
      NoteInstance ni = Notes.get(i);
      if(player.vec.z() + 30 < ni.cn_z) continue; 
      ni.Draw();
    }
    
    /*
    for(NoteInstance ni : Notes) {
      ni.Draw();
    }
    */
  }
  
  void Print() {
    for(NoteInstance e : Notes) {
      e.Print();
    }
  }
  
  void init_by_dammy(List<dammy_instance> ld) {
    Notes = new ArrayList<NoteInstance>();
    for(dammy_instance e : ld) {
      if(e.r + e.g + e.b == 0) {
        e.r = 50;
        e.g = 100;
        e.b = 200;
      }
      Notes.add(CreateNoteInstance(e));
    }
  }
}

class dammy_instance {
  float sz_x,sz_y,sz_z;
  float cn_x,cn_y,cn_z; //左手前上
  int r,g,b;
  boolean end_flag;
}

interface FunctionObjectClass {
  boolean func();
    
}
FunctionObjectClass default_function_callee;



void system_initialize() {
  default_function_callee = new NoOpe();
}

class NoOpe implements FunctionObjectClass {
  boolean func() {
    effect_audio.play();
    effect_audio.rewind();
    return false;
  }
}

class Disap implements FunctionObjectClass {
  NoteInstance ptr;
  public Disap(NoteInstance v) {
    ptr = v;
  }
  boolean func() {
    if(mousePressed){
      ptr.entry = false;
      music_audio.play();
      return true;
    }
    return false;
  }
}

class End implements FunctionObjectClass {
  boolean func() {
    if(mousePressed) {
      GameFinished = true;
      return true;
    }
    return false;
  }
}
