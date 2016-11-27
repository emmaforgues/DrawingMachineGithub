// Drawer class containing all the code to create both drawing mechanisms
class Drawer {

  // Coordinates of the mechanism
  float x, y;
  // Coordinates of the anchor point that 'attaches' the line to the mechanism
  float anchorX, anchorY;
  // Size of the big circle of the mechanism
  float size;
  // Both speeds for the rotation and translation of the big circle
  float speed, horizontalSpeed;

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
  Text rotationSpeedText, translationSpeedText;

  // Constructor for this class
  Drawer(float x, float speed, float horizontalSpeed) {
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
    
    String rotationSpeedString = speed + "";
    if (rotationSpeedString.length() > 4) rotationSpeedString = rotationSpeedString.substring(0, 4);
    else if (rotationSpeedString.length() < 4) {
      rotationSpeedString += "000";
      rotationSpeedString = rotationSpeedString.substring(0, 4);
    }
    
    rotationSpeedText = new Text(rotationSpeedString, x, y - 2);
    rotationSpeedText.centerX();
    
    String translationSpeedString = horizontalSpeed + "";
    if (translationSpeedString.length() > 4) translationSpeedString = translationSpeedString.substring(0, 4);
    else if (translationSpeedString.length() < 4) {
      translationSpeedString += "000";
      translationSpeedString = translationSpeedString.substring(0, 4);
    }
    
    translationSpeedText = new Text(translationSpeedString, x, y + 12);
    translationSpeedText.centerX();
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
      if (x + size / 2 == lx2 || x - size / 2 == lx1) horizontalSpeed *= -1;
      else if (x + size / 2 > lx2 || x - size / 2 < lx1) {
        horizontalSpeed *= -1;
        outOfBoundsCounter++;
      }
      // Modify the X coordinate by the translation speed
      x += horizontalSpeed;
    }
    
    // Calculate the X coordinate of the anchor point by using the angle
    anchorX = x + cos(angle) * size / 2;
    // Calculate the Y coordinate of the anchor point by using the angle
    anchorY = y + sin(angle) * size / 2;

    size = 70 * sizeSlider.value + 50;
    
    rotationSpeedText.setCoordinates(x, y - 2);
    translationSpeedText.setCoordinates(x, y + 12);
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
    
    //Set the fill color to white
    pg.fill(255);
    // Rotation Speed Text
    rotationSpeedText.draw(pg);
    // Translation Speed Text
    translationSpeedText.draw(pg);
    
    //Set the fill color to white
    pg.fill(255);
    // Draw the anchor point
    pg.ellipse(anchorX, anchorY, 7, 7);

    // Draw the drawing line using the anchor coordinates and the line end point coordinates
    pg.line(anchorX, anchorY, lineX, lineY);

    sizeSlider.draw(pg);
  }
}