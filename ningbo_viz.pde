PImage pimg;
PImage pring;
PGraphics mask;
PGraphics map;
PGraphics thing;
PFont pf;
float xxOffset = 0;
float xx = 0;
float sz = 0;


int _w = 1920;
int _h = 1080;

void setup() {
  size(1280, 720, OPENGL);
  frameRate(120);
  box = createGraphics(300, 200, OPENGL);
  pimg = loadImage("ningbo.png");
  pring = loadImage("ningbo map_r.png");
  mask = createGraphics(_w, _h, OPENGL);
  map = createGraphics(_w, _h, OPENGL);
  thing = createGraphics(_w, _h, OPENGL);
  
  mask.beginDraw();
  mask.background(0);
  mask.imageMode(CENTER);
  mask.translate(mask.width / 2, mask.height / 2);
  mask.scale(0.6);
  mask.image(pring, 0, 0);
  mask.endDraw();
  
  map.beginDraw();
  map.background(0);
  map.imageMode(CENTER);
  map.translate(map.width / 2, map.height / 2);
  map.scale(0.6);
  map.image(pimg, 0, 0);
  map.endDraw();
  
  imageMode(CENTER);
  pf = createFont("PingFang SC", 12);
  textFont(pf);
  setupData();
}

void draw() {
  rectMode(CORNERS);
  xx = ((float)(millis()) / 5000) % 1.0;
  xxOffset = ((float)(millis() + 2500) / 5000) % 1.0;
  sz = pow(xx, 1);
  thing.beginDraw();
  thing.colorMode(RGB, 255);
  thing.fill(0, 20);
  thing.noStroke();
  thing.rectMode(CORNERS);
  thing.rect(0, 0, thing.width, thing.height);
  thing.rectMode(CENTER);
  thing.colorMode(HSB, 1.0);
  thing.translate(thing.width / 2, thing.height / 2);
  thing.noFill();
  thing.strokeWeight(5);
  thing.rotate(radians((float)millis() / 30));
  thing.scale(sz * 50, sz * 50);
  thing.beginShape();
  thing.stroke(0.55 - noise(sz, float(millis()) / 1000) * 0.1, 1, noise(sz, float(millis()) / 100));
  for(float i = 0; i < 100; i++) {
    float deg = (float)Math.PI * 2.0 / 100 * i;
    float s = noise(deg, deg + (float)millis() / 1000) * 30 + 20;
    thing.vertex(cos(deg) * s, sin(deg) * s);
  }
  thing.endShape(CLOSE);
  thing.endDraw();
  
  background(0, 0,0);
  
  
  translate(width / 2, height / 2);
  
  //scale(0.6);
  imageMode(CENTER);
  image(map, 0, 0);
  //map.mask(mask);
  //image(map, 0, 0);
  //image(mask, 0, 0);
  rectMode(CENTER);
  for(stupidRenderer r: all) {
    r.render();
  }
  blendMode(ADD);
  thing.mask(mask);
  image(thing, 0, 0);
  
  renderGrid();
  renderGridTiny();
  //blendMode(NORMAL);
  renderBox();
}