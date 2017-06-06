JSONObject json;
ArrayList<stupidRenderer> all = new ArrayList<stupidRenderer>();
final float scaler = 4200;
class stupidRenderer {
  String status;
  boolean ix = false; 
  String name;
  PVector loc;
  float l1;
  float l2;
  float offset = random(50) + 20;
  float targetS;
  float curS;
  stupidRenderer(float l1, float l2, String name, String status) {
    loc = new PVector(l1 - 121.549887, -l2 + 29.8720259);
    this.name = name;
    this.l1 = l1;
    this.l2 = l2;
    this.status = status;
    if (l1 > 121.2451 && l1 < 121.8549 
      && l2 < 30.0952 && l2 > 29.6493) {
      all.add(this);
    }
    ix = (this.status.indexOf("违规") >= 0) && random(10) > 9.9;
  }
  void render() {
    float x = loc.x * scaler + width / 2;
    float y = loc.y * scaler + height / 2;
    pushMatrix();
    noStroke();
    //float op = 30;

    translate(loc.x * scaler, loc.y * scaler);
    //fill(255);
    //rect(0, 0, 5, 5);
    rotate(PI / 4);
    if (ix) {

      targetS = (1 - min(200, abs(dist(x, y, width / 2, height / 2) - xxOffset * 1500)) / 200) * min(1, xxOffset * 7);
      curS += (targetS - curS) * 0.1;
      float sn = 0.5 + 0.5 * sin(float(millis()) / 500);
      float sz = noise(loc.x * scaler + float(millis()) / 1000, loc.y * scaler) * curS * 4;
      float nn = noise(loc.y * scaler, loc.x * scaler, float(millis()) / 1000) * 1;
      
      pushMatrix();
      strokeWeight(1);
      stroke(255, sz * 50, 0, 255);
      //rotate(-PI / 4);
      noFill();
      scale(sz * 2 + .4 * sn + 1.2, sz * 2 + .4 * sn + 1.2);
      //line(0, 0, 0, -30 * nn);
      rect(0, 0, 5, 5);
      noStroke();
      popMatrix();

      fill(255, sz * 50, 0, 255);
      pushMatrix();
      scale(sz + 1.4 * sn + 0.3, sz + 1.4 * sn + 0.3);
      rect(0, 0, 3, 3);
      popMatrix();
      
      pushMatrix();
      rotate(-PI / 4);
      fill(255, (sz + 0.1) * 255);
      textFont(pf);
      translate(15, -15);
      //scale(0.8);
      textAlign(CENTER, CENTER);
      text("违规", 10, 0);
      popMatrix();
      
    } else {
      
      targetS = (1 - min(200, abs(dist(x, y, width / 2, height / 2) - xx * 1500)) / 200) * min(1, xx * 7);
      curS += (targetS - curS) * 0.1;
      float sn = 0.5 + 0.5 * sin(float(millis()) / 500);
      float sz = noise(loc.x * scaler + float(millis()) / 1000, loc.y * scaler) * curS * 4;
      float nn = noise(loc.y * scaler, loc.x * scaler, float(millis()) / 1000) * 1;
      fill(sz * 200 + 100);
      scale(sz + nn, sz + nn);
      rect(0, 0, 2, 2);
      
    }
    //blendMode(NORMAL);
    popMatrix();
  }
}


void setupData() {
  json = loadJSONObject("out.txt");
  JSONArray meituan = json.getJSONArray("meituan");
  for (int i = 0; i < meituan.size(); i++) {
    JSONObject o = meituan.getJSONObject(i);
    stupidRenderer s = new stupidRenderer(
      parseFloat(o.getString("经度")), 
      parseFloat(o.getString("纬度")), 
      o.getString("店铺名称"), 
      o.getString("店铺状态").trim());
  }
}