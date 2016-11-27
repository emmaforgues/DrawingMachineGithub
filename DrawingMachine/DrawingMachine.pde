import point2line.*;

// Array containing both drawers
Drawer[] drawers;

public static ArrayList<Input> inputToProcess = new ArrayList<Input>();

// PGraphics used to create layers (one for the mechanism and one for the drawing)
// Drawing Layer
private PGraphics drawing;
// Mechanism Layer
private PGraphics mechanism;

// Coordinates of the end point for both the lines coming from the mechanisms
// This is the '3rd point' of the triangle
private Vect2 endPoint;

// 2D vector representing the line between the 2 anchor points
private Vect2 base;
// Float values containing the lengths of both the 'drawing' lines
private float leftLineLength, rightLineLength;

// Disclaimer: Two circles (each centered on an anchor point and with the appropriate line length as radius) were used to calculate the coordinates of the point where the 2 lines meet.
// The idea is that one of the two points where the circles meet is the one where the lines meet.
// This point is the highest one (lowest absolute y value)
// For more information on how this was done visit this website: http://mathworld.wolfram.com/Circle-CircleIntersection.html

// Considering the left anchor point as the coordinates (0, 0), and the line formed by both anchor points as the x-axis
// This variable represents the absolute coordinates of the X value of the line joining both meeting points of the circles (end point of the vector under this)
private Vect2 circlesMeetingPointXDeltaCoords;
// This vector has for origin the left anchor point and for magnitude the distance between the left anchor point and the line joining both points where the circles meet
//It has the same angle as the base vector
private Vect2 circlesMeetingPointXDeltaVector;
// This vector has for origin the end point of the vector above and for magnitude the distance between that point and the point where both lines meet
// It is rotated of 90 degrees counter-clockwise from the base vector
private Vect2 circlesMeetingPointYDeltaVector;

// This is the magnitude of circlesMeetingPointXDeltaVector
private float circlesMeetingPointXDelta;
// This is the magnitude of circlesMeetingPointYDeltaVector
private float circlesMeetingPointYDelta;

private Slider left_lineLengthSlider, right_lineLengthSlider;

private Button pauseButton;

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
  drawers[0] = new Drawer(width / 4, random(0.04, 0.1), 1);
  // Creating the second drawer directly into the array
  drawers[1] = new Drawer(width * 3 / 4, 0.1, 1);

  // Initialize this variable
  endPoint = new Vect2();

  // Give these variable the good values, taking these values from the 2 drawing machines
  leftLineLength = drawers[0].lineLength;
  rightLineLength = drawers[1].lineLength;
  
  // Left line length slider
  left_lineLengthSlider = new Slider(50, 100, 100, false, (leftLineLength - 250) / 100);
  
  // Right line length slider
  right_lineLengthSlider = new Slider(width - 50, 100, 100, false, (rightLineLength - 250) / 100);
  right_lineLengthSlider.flip();
  
  // Pause Button Shapes for both states
  Shape pauseButtonShape1 = new Shape(new Vect2[]{new Vect2(0, 0), new Vect2(5, 0), new Vect2(5, 15), new Vect2(0, 15)});
  Shape pauseButtonShape2 = new Shape(new Vect2[]{new Vect2(8, 0), new Vect2(13, 0), new Vect2(13, 15), new Vect2(8, 15)});
  Shape pauseButtonShapePressed = new Shape(new Vect2[]{new Vect2(0, 0), new Vect2(0, 15), new Vect2(10, 7.5)});
  
  // Pause Button initialization
  pauseButton = new Button(10, 10, new Shape[]{pauseButtonShape1, pauseButtonShape2}, 255);
  
  // Pause Button Attributes
  pauseButton.setPressedShapes(new Shape[]{pauseButtonShapePressed});
  pauseButton.setActiveClickBounds(new Vect2[]{new Vect2(0, 0), new Vect2(8, 0), new Vect2(8, 15), new Vect2(0, 15)});
  pauseButton.setPressedClickBounds(new Vect2[]{new Vect2(0, 0), new Vect2(8, 0), new Vect2(8, 15), new Vect2(0, 15)});
}

void update() {
  leftLineLength = 250 + 100 * (1 - left_lineLengthSlider.value);
  rightLineLength = 250 + 100 * (1 - right_lineLengthSlider.value);
  
  // Update both drawers before proceeding with calculations
  for (Drawer d : drawers) d.update(pauseButton.pressed);

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
  // Call the update method which will calculate the end points for the lines as well as update the drawers
  update();

  // Start drawing ('open') the first layer containing the mechanisms
  mechanism.beginDraw();
  // Set the background to black in order to 'refresh' the screen
  mechanism.background(0);

  // Call the draw function in both drawers
  for (Drawer d : drawers) {
    d.draw(mechanism);
  }
  
  left_lineLengthSlider.draw(mechanism);
  right_lineLengthSlider.draw(mechanism);
  pauseButton.draw(mechanism);

  // Stop drawing ('close') the first layer containing the mechanisms
  mechanism.endDraw();

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

void mousePressed() { for (Input input : inputToProcess) input.mousePressed(); }
void mouseReleased() { for (Input input : inputToProcess) input.mouseReleased(); }
void mouseDragged() { for (Input input : inputToProcess) input.mouseDragged(); }
void mouseClicked() { for (Input input : inputToProcess) input.mouseClicked(); }