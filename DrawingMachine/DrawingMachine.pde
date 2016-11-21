private Drawer[] drawers;

private PGraphics drawing;
private PGraphics mechanism;

private float endPointX, endPointY;

void setup() {
  size(500, 500);
  smooth();
  
  //pgraphic = layer for the drawing
  drawing = createGraphics(width, height);
  //layer for mechanism 
  mechanism = createGraphics(width, height);
  
  drawers = new Drawer[2];
  drawers[0] = new Drawer(mechanism, width / 4, height * 4 / 5, 50, 0.1, 1);
  drawers[1] = new Drawer(mechanism, width * 3 / 4, height * 4 / 5, 50, 0.1, 1);
}

void update() {
  float AB = dist(drawers[0].anchorX, drawers[0].anchorY, drawers[1].anchorX, drawers[1].anchorY);
  float AC = drawers[0].lineLength;
  float BC = drawers[1].lineLength;
  float AD = (sq(AB) + sq(AC) - sq(BC)) / (2 * AB);
  float alpha = asin(abs(AD / AB) * abs(drawers[0].anchorY - drawers[1].anchorY) / AD);
  float DE = AD * tan(alpha);
  float AE = sqrt(sq(DE) + sq(AD));
  endPointX = drawers[0].anchorX + AE;
  endPointY = drawers[0].anchorY - sqrt(sq(AC) - sq(endPointX - drawers[0].anchorX));
  println(BC, ",", dist(drawers[1].anchorX, drawers[1].anchorY, endPointX, endPointY));
  
  for (Drawer d : drawers) {
    d.lineX = endPointX;
    d.lineY = endPointY;
  }
}

void draw() {
  update();
  
  mechanism.beginDraw();
  mechanism.background(0);
  
  for (Drawer d : drawers) {
    d.update();
    d.draw();
  }
  
  mechanism.endDraw();
  
  drawing.beginDraw();
  drawing.stroke(255);
  drawing.point(endPointX, endPointY);
  drawing.endDraw();
  
  image(mechanism, 0, 0);
  image(drawing, 0, 0);
}