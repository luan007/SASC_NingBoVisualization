void renderGrid() {
  pushMatrix();
  blendMode(ADD);
  strokeWeight(1);
  colorMode(HSB, 1.0);
  translate(-width / 2, -height / 2);
  float s = 20;
  for(float x = 0; x < width; x+= s*2) {
    noFill();
    for(float y = 0; y < height; y+= s*2) {
      
      float sz = noise(x / 5, y / 5, float(millis()) / 1000) / 3;
      float sz2 = noise(x / 555, y / 555, float(millis()) / 1000);
      float ts = (1 - min(200, abs(dist(x, y, width / 2, height / 2) - xx * 1500 + sz2 * 600)) / 200) * min(1, xx * 7) + sz;
      
      stroke(0.55, 1, ts, 0.3);
      pushMatrix();
      translate(x, y);
      line(-s, 0, s, 0);
      line(0, -s, 0, s);
      popMatrix();
    }
  }
  colorMode(RGB, 255);
  popMatrix();
}

void renderGridTiny() {
  pushMatrix();
  blendMode(ADD);
  strokeWeight(1);
  colorMode(HSB, 1.0);
  translate(-width / 2, -height / 2);
  float s = 10;
  for(float x = 0; x < width; x+= s*2) {
    noFill();
    for(float y = 0; y < height; y+= s*2) {
      
      float sz = noise(x / 5, y / 5, float(millis()) / 1000) / 3;
      float sz2 = noise(x / 555, y / 555, float(millis()) / 1000);
      float ts = (1 - min(200, abs(dist(x, y, width / 2, height / 2) - xx * 1500 + sz2 * 600)) / 200) * min(1, xx * 7) + sz;
      
      stroke(0.55,ts,ts,0.3);
      pushMatrix();
      translate(x, y);
      line(-s, 0, s, 0);
      line(0, -s, 0, s);
      popMatrix();
    }
  }
  colorMode(RGB, 255);
  popMatrix();
}


PGraphics box;

void renderBox() {
  box.beginDraw();
  
  box.fill(0, 10);
  box.rect(0, 0, box.width, box.height);
  
  float x = xx * box.width;
  
  box.textFont(pf);
  box.stroke(255);
  box.strokeWeight(2);
  box.translate(x, 0);
  box.line(0, 0, 0, box.height);
  
  box.endDraw();
  
  pushMatrix();
  {
    float w = box.width;
    float h = box.height;
    translate(width / 2 - w - 30, height / 2 - h - 30);
    imageMode(CORNERS);
    image(box, 0, 0);
    imageMode(CENTER);
  }
  popMatrix();
}