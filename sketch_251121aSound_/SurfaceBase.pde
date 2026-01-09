
class SurfaceBase {
  // バッファサイズ
  final int BUFFER_WIDTH = 300; 
  final int BUFFER_HEIGHT = 300;

  int _iClassIndex = 0;
  
  PImage[] myImages = new PImage[2];
  int currentImgIdx = 0;
  
  CornerPinSurface surface;
  PGraphics offscreen;
  
  int _iKeyParam = 0; 
  int iBgRGB[]; 
  int iCubeRGB[][];

  SurfaceBase(int classIndex) {
    _iClassIndex = classIndex;
    // Keystoneのサーフェス作成
    surface = ks.createCornerPinSurface(BUFFER_WIDTH, BUFFER_HEIGHT, 20);
    
    offscreen = createGraphics(BUFFER_WIDTH, BUFFER_HEIGHT, P3D);
    iBgRGB = new int[3];
    iCubeRGB = new int[9][3];
    setBgRGB(0);
    setCubeRGB(0);
  }
  
  // 画像を2枚セット
  void setImages(PImage img1, PImage img2) {
    myImages[0] = img1;
    myImages[1] = img2;
  }

  // 画像切り替え
  void toggleImage() {
    currentImgIdx = 1 - currentImgIdx; 
  }
  
  // バッファへの描画
  void drawToBuf() {
    offscreen.beginDraw();
    offscreen.background(0);
    
    if (_iKeyParam == 0) {
      // 画像モード
      offscreen.colorMode(RGB, 256);
      PImage targetTex = myImages[currentImgIdx];
      
      if (targetTex != null) {
        offscreen.image(targetTex, 0, 0, BUFFER_WIDTH, BUFFER_HEIGHT);
      } else {
        offscreen.fill(100);
        offscreen.rect(0, 0, BUFFER_WIDTH, BUFFER_HEIGHT);
      }
      
    } else if (_iKeyParam == 1) {
      offscreen.colorMode(RGB, 256);
      createBgOneColor(1); 
    } else if (_iKeyParam == 2) {
      offscreen.colorMode(RGB, 256);
      createCubeRect();
    }
    offscreen.endDraw();
  }
  
  void render(){
    surface.render(offscreen);
  }
  
  void setKeyParam(int iKeyParam) {
    _iKeyParam = iKeyParam;
  }
  
  void setBgRGB(int iIndex) {
    if (iIndex == 0) {
      for (int i = 0; i < 3; i++) { iBgRGB[i] = 0; }
    } else {
      for (int i = 0; i < 3; i++) { iBgRGB[i] = (int)random(256); }
    }
  }
  
  void setCubeRGB(int iIndex) {
    if (iIndex == 0) {
      for (int i=0; i<9; i++) { for(int j=0; j<3; j++) iCubeRGB[i][j]=0; }
    } else if (iIndex == 1) {
      int[] tmp = {(int)random(256), (int)random(256), (int)random(256)};
      for (int i=0; i<9; i++) { for(int j=0; j<3; j++) iCubeRGB[i][j]=tmp[j]; }
    } else {
      for (int i=0; i<9; i++) { for(int j=0; j<3; j++) iCubeRGB[i][j]=(int)random(256); }
    }
  }
  
  void createBgOneColor(int type) {
    float diameter = BUFFER_WIDTH * 0.9;
    if (type > 0) {
      diameter = sin(frameCount / 10.0) * BUFFER_WIDTH * 0.3 + BUFFER_WIDTH * 0.6;
    }
    offscreen.fill(iBgRGB[0], iBgRGB[1], iBgRGB[2]);
    offscreen.rectMode(CENTER);
    offscreen.rect(BUFFER_WIDTH / 2, BUFFER_HEIGHT / 2, diameter, diameter);
  }
  
  void createCubeRect() {
    int margin = 5;
    int cellSize = (BUFFER_WIDTH - margin * 4) / 3;
    offscreen.rectMode(CORNER);
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        offscreen.fill(iCubeRGB[i * 3 + j][0], iCubeRGB[i * 3 + j][1], iCubeRGB[i * 3 + j][2]);
        float xPos = margin + i * (cellSize + margin);
        float yPos = margin + j * (cellSize + margin);
        offscreen.rect(xPos, yPos, cellSize, cellSize);
      }
    }
  }
}
