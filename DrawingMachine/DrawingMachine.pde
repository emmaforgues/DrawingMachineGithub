import point2line.*;

// Array containing both drawers
Drawer[] drawers;

// List containing all input sub-classes
// Used to call all the input related (mouse and keyboard) methods in the said sub-classes
static ArrayList<Input> inputToProcess = new ArrayList<Input>();

// Graphical User Interface class containing most the UI elements
// This is mostly a collection of UI elements used for code clarity
GUI gui;

// True when the mechanism is paused
boolean paused;
//True when the mechanism shouldn't be showed
boolean hideMechanism;

// PGraphics used to create layers (one for the mechanism and one for the drawing)
// Drawing Layer
PGraphics drawing;
// Mechanism Layer
PGraphics mechanism;

// Coordinates of the end point for both the lines coming from the mechanisms
// This is the '3rd point' of the triangle
Vect2 endPoint;

// 2D vector representing the line between the 2 anchor points
Vect2 base;
// Float values containing the lengths of both the 'drawing' lines
float leftLineLength, rightLineLength;

// Disclaimer: Two circles (each centered on an anchor point and with the appropriate line length as radius) were used to calculate the coordinates of the point where the 2 lines meet.
// The idea is that one of the two points where the circles meet is the one where the lines meet.
// This point is the highest one (lowest absolute y value)
// For more information on how this was done visit this website: http://mathworld.wolfram.com/Circle-CircleIntersection.html

// Considering the left anchor point as the coordinates (0, 0), and the line formed by both anchor points as the x-axis
// This variable represents the absolute coordinates of the X value of the line joining both meeting points of the circles (end point of the vector under this)
Vect2 circlesMeetingPointXDeltaCoords;
// This vector has for origin the left anchor point and for magnitude the distance between the left anchor point and the line joining both points where the circles meet
//It has the same angle as the base vector
Vect2 circlesMeetingPointXDeltaVector;
// This vector has for origin the end point of the vector above and for magnitude the distance between that point and the point where both lines meet
// It is rotated of 90 degrees counter-clockwise from the base vector
Vect2 circlesMeetingPointYDeltaVector;

// This is the magnitude of circlesMeetingPointXDeltaVector
float circlesMeetingPointXDelta;
// This is the magnitude of circlesMeetingPointYDeltaVector
float circlesMeetingPointYDelta;

void setup() {
  size(720, 600);
  smooth();

  //creating the layer for the drawing with the screen size
  drawing = createGraphics(width, height);
  //layer for mechanism with the screen size
  mechanism = createGraphics(width, height);

  // Initializing the array for both the drawers
  drawers = new Drawer[2];
  // Creating the first drawer directly into the array
  drawers[0] = new Drawer(width / 4, random(0.04, 0.1), 1);
  // Creating the second drawer directly into the array
  drawers[1] = new Drawer(width * 3 / 4, 0.1, 1);

  // Initialize this variable
  endPoint = new Vect2();

  // Initialize the GUI object
  gui = new GUI();
}

void update() {
  // Set the window title to include the current frame rate
  surface.setTitle("Drawing Machine - " + nfc(frameRate, -2) + "fps");

  // Update the GUI object and all its components
  gui.update();

  // Give these variable the good and updated values, taking these values from the 2 drawing machines
  leftLineLength = drawers[0].lineLength;
  rightLineLength = drawers[1].lineLength;

  // Update both drawers before proceeding with calculations
  for (Drawer d : drawers) d.update(paused);

  // Update the value of the vector representing the line between both anchor points
  base = new Vect2(drawers[1].anchorX - drawers[0].anchorX, drawers[1].anchorY - drawers[0].anchorY);

  // x (website)
  circlesMeetingPointXDelta = (sq(base.magnitude()) - sq(rightLineLength) + sq(leftLineLength)) / (2 * base.magnitude());
  // a (website)
  circlesMeetingPointYDelta = sqrt((rightLineLength - base.magnitude() - leftLineLength) * (leftLineLength - rightLineLength - base.magnitude()) * (rightLineLength + leftLineLength - base.magnitude()) * (base.magnitude() + rightLineLength + leftLineLength)) / base.magnitude();

  // x vector
  circlesMeetingPointXDeltaVector = base.clone();
  // x length
  circlesMeetingPointXDeltaVector.setMagnitude(circlesMeetingPointXDelta);

  // point on base line 
  circlesMeetingPointXDeltaCoords = new Vect2(drawers[0].anchorX + circlesMeetingPointXDeltaVector.x, drawers[0].anchorY + circlesMeetingPointXDeltaVector.y);

  circlesMeetingPointYDeltaVector = circlesMeetingPointXDeltaVector.clone();
  circlesMeetingPointYDeltaVector.rotateLeft();
  // 'a' length / 2
  circlesMeetingPointYDeltaVector.setMagnitude(circlesMeetingPointYDelta / 2);

  // Coordinates of the point where the lines will finally meet
  endPoint.set(circlesMeetingPointXDeltaCoords.x + circlesMeetingPointYDeltaVector.x, circlesMeetingPointXDeltaCoords.y + circlesMeetingPointYDeltaVector.y);

  // Set the end point of both lines (one for each drawer) to the calculated point
  for (Drawer d : drawers) {
    d.lineX = endPoint.x;
    d.lineY = endPoint.y;
  }
}

void draw() {
  // Call the update method which will calculate the end points for the lines as well as update the drawers and the GUI
  update();

  // Start drawing ('open') the first layer containing the mechanisms
  mechanism.beginDraw();
  // Set the background to black in order to 'refresh' the screen
  mechanism.background(0);

  // If the mechanism should be hidden, simply stop drawing it here
  if (hideMechanism) mechanism.endDraw();
  // Else, draw the whole mechanism
  else {
    //Draw the GUI
    gui.draw(mechanism);

    // Call the draw function in both drawers
    for (Drawer d : drawers) {
      d.draw(mechanism);
    }

    // Stop drawing ('close') the first layer containing the mechanisms
    mechanism.endDraw();
  }

  // Start drawing ('open') the second layer containing only the drawing
  // Note that the background is not set to black because the drawing has to stay visible and not disappear every update
  drawing.beginDraw();
  // Set the stroke to white
  drawing.stroke(255);
  // Draw a point at the coordinates where both lines meet
  // This is what creates the actual drawing
  drawing.point(endPoint.x, endPoint.y);

  // Stop drawing ('close') the second layer containing only the drawing
  drawing.endDraw();

  // image() draws an image on the screen at specified coordinates
  // The image being drawn here is the mechanism layer which contains both mechanisms
  image(mechanism, 0, 0);
  // As for the line above, this draws the second layer containing the drawing
  // It draws the layer above the mechanism
  image(drawing, 0, 0);
}

// Check for keyboard input
void keyPressed() {
  // Pause the mechanism when pressing 'P'
  if (key == 'S' || key == 's') paused = !paused;
  // Clear the drawing when pressing 'C'
  else if (key == 'C' || key == 'c') drawing.clear();
  // Hide the mechanism when pressing 'H'
  else if (key == 'H' || key == 'h') hideMechanism = !hideMechanism;
  // Increase the rotation speed of the selected drawers when pressing the Up-Arrow
  else if (keyCode == UP) {
    for (Drawer drawer : drawers) if (drawer.selected) drawer.speed += 0.01;
  }
  // Decrease the rotation speed of the selected drawers when pressing the Down-Arrow
  else if (keyCode == DOWN) {
    for (Drawer drawer : drawers) if (drawer.selected) drawer.speed -= 0.01;
  }
  // Decrease the translation speed of the selected drawers when pressing the Left-Arrow
  else if (keyCode == LEFT) {
    for (Drawer drawer : drawers) if (drawer.selected) drawer.horizontalSpeed -= 0.1;
  }
  // Increase the translation speed of the selected drawers when pressing the Right-Arrow
  else if (keyCode == RIGHT) {
    for (Drawer drawer : drawers) if (drawer.selected) drawer.horizontalSpeed += 0.1;
  }
  // "Print" the current screen with all the on-screen elements to the sketch folder when pressing 'P'
  else if (key == 'P' || key == 'p') saveFrame("screenPrint##.png");
}

void mousePressed() {
  // Call the mousePressed method in all the input sub-classes
  for (Input input : inputToProcess) input.mousePressed();
}
void mouseReleased() {
  // Call the mouseReleased method in all the input sub-classes
  for (Input input : inputToProcess) input.mouseReleased();
}
void mouseDragged() {
  // Call the mouseDragged method in all the input sub-classes
  for (Input input : inputToProcess) input.mouseDragged();
}
void mouseClicked() {
  // Call the mouseClicked method in all the input sub-classes
  for (Input input : inputToProcess) input.mouseClicked();
}