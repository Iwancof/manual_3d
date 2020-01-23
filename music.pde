import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;


Minim minim;  //Minim型変数であるminimの宣言
AudioPlayer music_audio;  //サウンドデータ格納用の変数

AudioPlayer effect_audio;

void sound_test() {
  minim = new Minim(this);
  
  music_audio = minim.loadFile("firefly.mp3");  
  music_audio.play();
  
  effect_audio = minim.loadFile("effect.mp3");
}

void sound_initialize() {
  minim = new Minim(this);

  music_audio = minim.loadFile("firefly.mp3");
  effect_audio = minim.loadFile("effect.mp3");
}
