// Array containing both drawers
private Drawer[] drawers;

// PGraphics used to create layers (one for the mechanism and one for the drawing)
  // Drawing Layer
private PGraphics drawing;
  // Mechanism Layer
private PGraphics mechanism;

// Coordinates of the end point for both the lines coming from the mechanism
  // This is the '3rd point' of the triangle
private float endPointX, endPointY;

void setup() {
  size(720, 480);
  smooth();
  
  //creating the layer for the drawing with the screen size
  drawing = createGraphics(width, height);
  //layer for mechanism with the screen size
  mechanism = createGraphics(width, height);
  
  // Initializing the array for both the drawers
  drawers = new Drawer[2];
  // Creating the first drawer directly into the array
  drawers[0] = new Drawer(mechanism, width / 4, height * 4 / 5, 50, 0.1, 1);
  // Creating the second drawer directly into the array
  drawers[1] = new Drawer(mechanism, width * 3 / 4, height * 4 / 5, 50, 0.1, 1);
}

void update() {
  // Update both drawers before proceeding with calculations
  for (Drawer d : drawers) d.update();
  
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
  
  // Set the end point of both lines (one for each drawer) to the calculated point
  for (Drawer d : drawers) {
    d.lineX = endPointX;
    d.lineY = endPointY;
  }
}

void draw() {
  // Call the update method which will calculate the end points for the lines as well as update the drawers
  update();
  
  // Start drawing ('open') the first layer containing the mechanisms
  mechanism.beginDraw();
  // Set the background to black in order to 'refresh' the screen
  mechanism.background(0);
  
  // Call the draw function in both drawers
  for (Drawer d : drawers) d.draw();
  
  // Stop drawing ('close') the first layer containing the mechanisms
  mechanism.endDraw();
  
  // Start drawing ('open') the second layer containing only the drawing
    // Note that the background is not set to black because the drawing has to stay visible and not disappear every update
  drawing.beginDraw();
  // Set the stroke to white
  drawing.stroke(255);
  // Draw a point at the coordinates where both lines meet
    // This is what creates the actual drawing
  drawing.point(endPointX, endPointY);
  // Stop drawing ('close') the second layer containing only the drawing
  drawing.endDraw();
  
  // image() draws an image on the screen at specified coordinates
    // The image being drawn here is the mechanism layer which contains both mechanisms
  image(mechanism, 0, 0);
  // As for the line above, this draws the second layer containing the drawing
    // It draws the layer above the mechanism
  image(drawing, 0, 0);
}