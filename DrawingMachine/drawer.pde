// Drawer class containing all the code to create both drawing mechanisms
class Drawer extends Input {

  // Coordinates of the mechanism
  float x, y;
  // Coordinates of the anchor point that 'attaches' the line to the mechanism
  float anchorX, anchorY;
  // Size of the big circle of the mechanism
  float size;
  // Both speeds for the rotation and translation of the big circle
  float speed, horizontalSpeed, horizontalDelta = 1;

  // length of the line that will actually draw
  float lineLength;

  // Coordinates of the end point of the line
  float lineX = width / 2, lineY = height / 2;

  // Angle at which the rotation of the circle actually is
  // This is used to calculate the position of the anchor point
  float angle;
  // Coordinates of both end points of the line under the big circle 
  // (used as a 'boundary' for the translation movement of said big circle)
  float lx1, lx2, ly1, ly2;
  int outOfBoundsCounter;

  Slider sizeSlider;

  boolean selected;
  Bounds clickableBounds;

  // Constructor for this class
  Drawer(float x, float speed, float horizontalSpeed) {
    super();
    // X coordinate
    this.x = x;
    // Y coordinate (always starts at the bottom so no need for an argument to be passed through the constructor)
    y = height * 4 / 5;
    // Size
    size = random(50, 120);
    // Rotation Speed
    this.speed = speed;
    // Translation Speed
    this.horizontalSpeed = horizontalSpeed;

    // Random angle from 175 to 360 degrees (starting angle for the anchor point)
    angle = random(TWO_PI);
    // Random length for the drawing line
    lineLength = random(250, 350);

    // Coordinates of the boundary line under the big circle
    lx1 = x - size;
    lx2 = x + size;
    ly1 = y;
    ly2 = y;

    // Calculate the X coordinate of the anchor point by using the angle
    anchorX = x + cos(angle) * size / 2;
    // Calculate the Y coordinate of the anchor point by using the angle
    anchorY = y + sin(angle) * size / 2;

    sizeSlider = new Slider(x, height - 15, 150, true, (size - 50) / 70);

    clickableBounds = new Bounds(new Vect2[]{new Vect2(x - size / 2, y), new Vect2(x + cos(3 * QUARTER_PI) * size / 2, y + sin(3 * QUARTER_PI) * size / 2), new Vect2(x, y - size / 2), new Vect2(x + cos(QUARTER_PI) * size / 2, y + sin(QUARTER_PI) * size / 2), new Vect2(x + size / 2, y), new Vect2(x + cos(7 * QUARTER_PI) * size / 2, y + sin(7 * QUARTER_PI) * size / 2), new Vect2(x, y + size / 2), new Vect2(x + cos(5 * QUARTER_PI) * size / 2, y + sin(5 * QUARTER_PI) * size / 2)});
  }

  // Update method
  void update(boolean paused) {
    // Modifying the rotation angle by the speed
    if (!paused) {
      angle += speed;

      if (outOfBoundsCounter == 60) {
        x = lx1 + (lx2 - lx1) / 2;
        outOfBoundsCounter = 0;
      }

      // Check if the big circle is out of bounds, if yes change its translation direction
      if (x + size / 2 == lx2 || x - size / 2 == lx1) {
        horizontalDelta *= -1;
        outOfBoundsCounter = 0;
      } else if (x + size / 2 > lx2 || x - size / 2 < lx1) {
        horizontalDelta *= -1;
        outOfBoundsCounter++;
      }
      // Modify the X coordinate by the translation speed
      x += horizontalSpeed * horizontalDelta;
    }

    // Calculate the X coordinate of the anchor point by using the angle
    anchorX = x + cos(angle) * size / 2;
    // Calculate the Y coordinate of the anchor point by using the angle
    anchorY = y + sin(angle) * size / 2;

    size = 70 * sizeSlider.value + 50;

    clickableBounds.setVertices(new Vect2[]{new Vect2(x - size / 2, y), new Vect2(x + cos(3 * QUARTER_PI) * size / 2, y + sin(3 * QUARTER_PI) * size / 2), new Vect2(x, y - size / 2), new Vect2(x + cos(QUARTER_PI) * size / 2, y + sin(QUARTER_PI) * size / 2), new Vect2(x + size / 2, y), new Vect2(x + cos(7 * QUARTER_PI) * size / 2, y + sin(7 * QUARTER_PI) * size / 2), new Vect2(x, y + size / 2), new Vect2(x + cos(5 * QUARTER_PI) * size / 2, y + sin(5 * QUARTER_PI) * size / 2)});
  }

  // Draw method
  // PGraphics containing the drawing layer
  void draw(PGraphics pg) {
    pg.strokeWeight(0.4);
    // Set the fill color to black
    pg.fill(0);
    // Set the stroke color to white
    pg.stroke(255);

    // Draw the boundary line
    pg.line(lx1, ly1, lx2, ly2);
    // Draw the left side circle at the end of the boundary line
    pg.ellipse(lx1 - 5, ly1, 10, 10);
    // Draw the right side circle at the end of the boundary line
    pg.ellipse(lx2 + 5, ly2, 10, 10);

    // Draw the big circle of the mechanism
    pg.ellipse(x, y, size, size);

    if (selected) {
      for (int i = 0; i < size / 4; i++) {
        pg.stroke(255 - 255 * i * 4 / size);
        pg.ellipse(x, y, size - i, size - i);
      }
    }

    pg.stroke(255);

    //Set the fill color to white
    pg.fill(255);
    // Draw the anchor point
    pg.ellipse(anchorX, anchorY, 7, 7);

    // Draw the drawing line using the anchor coordinates and the line end point coordinates
    pg.line(anchorX, anchorY, lineX, lineY);

    pg.textAlign(CENTER);
    pg.text("Click", x, y + 6);

    sizeSlider.draw(pg);
  }

  void mousePressed() {
  }

  void mouseReleased() {
  }

  void mouseDragged() {
  }

  void mouseClicked() {
    if (!clickableBounds.isOutOfBounds(mouseX, mouseY)) selected = !selected;
  }
}