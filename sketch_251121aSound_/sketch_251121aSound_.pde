import deadpixel.keystone.*;
import ddf.minim.*;

// --- 設定エリア ---
int n_img = 6; 

String[][] fileList = {
  { "screen1-1.jpg", "screen1-2.jpg" }, 
  { "screen2-1.jpg", "screen2-2.jpg" }, 
  { "screen3-1.jpg", "screen3-2.jpg" }, 
  { "screen4-1.jpg", "screen4-2.jpg" }, 
  { "screen5-1.jpg", "screen5-2.jpg" }, 
  { "screen6-1.jpg", "screen6-2.jpg" }  
};

String bgmFileName = "mario_bgm.mp3";
String seFileName = "marioDokan.mp3";

// --- グローバル変数 ---
Keystone ks;
Minim minim;
AudioPlayer bgmPlayer;
AudioPlayer sePlayer;

// ★修正: 初回に0が選ばれても大丈夫なように -1 で初期化
int formers = -1; 
int targetIndex;

SurfaceBase[] surfaces = new SurfaceBase[n_img];

void setup() {
  fullScreen(P3D);
  frameRate(30);

  ks = new Keystone(this);
  minim = new Minim(this);

  bgmPlayer = minim.loadFile(bgmFileName);
  if (bgmPlayer != null) {
    bgmPlayer.loop();
  } else {
    println("BGMが見つかりません: " + bgmFileName);
  }

  sePlayer = minim.loadFile(seFileName);
  if (sePlayer == null) {
    println("SEが見つかりません: " + seFileName);
  }

  for (int i = 0; i < n_img; i++) {
    surfaces[i] = new SurfaceBase(i);

    PImage img1 = loadImage(fileList[i][0]);
    PImage img2 = loadImage(fileList[i][1]);

    if (img1 == null) img1 = createDummyImage(color(255, 0, 0)); 
    if (img2 == null) img2 = createDummyImage(color(0, 0, 255)); 

    surfaces[i].setImages(img1, img2);

    int cols = 3; 
    float w = 300; 
    float h = 300; 
    float gap = 20; 

    float startX = 50 + (i % cols) * (w + gap); 
    float startY = 50 + (i / cols) * (h + gap); 
  }
}

PImage createDummyImage(int c) {
  PImage img = createImage(300, 300, RGB);
  img.loadPixels();
  for (int p=0; p<img.pixels.length; p++) img.pixels[p] = c;
  img.updatePixels();
  return img;
}

void draw() {
  background(0);

  for (int i = 0; i < n_img; i++) {
    surfaces[i].drawToBuf();
  }

  for (int i = 0; i < n_img; i++) {
    surfaces[i].render();
  }
}

void keyPressed() {
  switch(key) {
  case 'c':
    ks.toggleCalibration();
    break;
  case 'l':
    ks.load();
    break;
  case 's':
    ks.save();
    break;

  case 't':
    // 効果音
    if (sePlayer != null) {
      sePlayer.rewind();
      sePlayer.play();
    }

    // ★修正: ここでは関数を「呼ぶ」だけにします
    targetIndex = chooseScreen();
    
    println("Switching Surface No: " + targetIndex);
    
    surfaces[targetIndex].toggleImage();
    
    // 初回(-1)以外なら、前の画像の選択を解除
    if (formers != -1) {
      surfaces[formers].toggleImage();
    }
    
    formers = targetIndex;
    break;

    // モード切替
  case '0':
  case '1':
  case '2':
    int mode = key - '0';
    for (int i = 0; i < n_img; i++) {
      surfaces[i].setKeyParam(mode);
      if (mode == 1) surfaces[i].setBgRGB(1);
      if (mode == 2) surfaces[i].setCubeRGB(2);
    }
    break;
  }
}

// ★修正: 関数定義は keyPressed の外側（ここ）に移動しました
int chooseScreen() {
  int next = int(random(n_img));
  
  // もし前回と同じ値だったら、再帰呼び出しの結果を return する
  if (next == formers) {
    return chooseScreen(); 
  }
  
  // 違う値ならそれを返す
  return next;
}
