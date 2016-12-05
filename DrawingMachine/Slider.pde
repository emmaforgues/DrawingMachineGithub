// Class that creates a slider (used in the GUI)
class Slider extends Input {
  
  // Slider's position
  float x, y;
  // Slider triangle's corners positions
  Vect2 t1, t2, t3;
  // Length of the slider
  float sliderLength;
  // True if the slider is horizontal
    // False if vertical
  boolean isHorizontal;
  // 0 to 1 range representing the current value of the slider
  float value;
  
  // Clickable bounds of the slider's triangle
  Bounds clickableBounds;
  // Bounds of the slider once it was clicked on
    // Column if horizontal and line if vertical
  Bounds sliderBounds;
  
  // True if the user is pressing the mouse button and is currently on the slider's triangle
  boolean clicking;
  // Used to flip the slider (-1 would be the flipped value)
  int flipped = 1;
  
  // Constructor
  Slider(float x, float y, float sliderLength, boolean isHorizontal, float value) {
    // Call the super constructor
    super();
    
    // Set the starting values
    this.x = x;
    this.y = y;
    this.sliderLength = sliderLength;
    this.isHorizontal = isHorizontal;
    this.value = value;
    
    // Calculate the slider's triangle corners
    if (isHorizontal) {
      t1 = new Vect2(x - sliderLength / 2 + (sliderLength - 10) * value, y);
      t2 = new Vect2(x - sliderLength / 2 + 5 + (sliderLength - 10) * value, y - 7);
      t3 = new Vect2(x - sliderLength / 2 + 10 + (sliderLength - 10) * value, y);
    } else {
      t1 = new Vect2(x, y - sliderLength / 2 + (sliderLength - 10) * value);
      t2 = new Vect2(x + 7, y - sliderLength / 2 + 5 + (sliderLength - 10) * value);
      t3 = new Vect2(x, y - sliderLength / 2 + 10 + (sliderLength - 10) * value);
    }
  
    // Set the clickable bounds
    clickableBounds = new Bounds(new Vect2[]{t1, t2, t3});
    
    // Set the slider bounds
    if (isHorizontal) sliderBounds = new Bounds(new Vect2[]{new Vect2(x - sliderLength / 2, 0), new Vect2(x + sliderLength / 2, 0), new Vect2(x + sliderLength / 2, height), new Vect2(x - sliderLength / 2, height)});
    else sliderBounds = new Bounds(new Vect2[]{new Vect2(0, y - sliderLength / 2), new Vect2(0, y + sliderLength / 2), new Vect2(width, y + sliderLength / 2), new Vect2(width, y - sliderLength / 2)});
  }
  
  // Same as update
  // Updates the clickable bounds and the slider's triangle
  void tick() {
    if (isHorizontal) {
      t1.set(x - sliderLength / 2 + (sliderLength - 10) * value, y);
      t2.set(x - sliderLength / 2 + 5 + (sliderLength - 10) * value, y - flipped * 7);
      t3.set(x - sliderLength / 2 + 10 + (sliderLength - 10) * value, y);
    } else {
      t1.set(x, y - sliderLength / 2 + (sliderLength - 10) * value);
      t2.set(x + flipped * 7, y - sliderLength / 2 + 5 + (sliderLength - 10) * value);
      t3.set(x, y - sliderLength / 2 + 10 + (sliderLength - 10) * value);
    }

    clickableBounds.setVertices(new Vect2[]{t1, t2, t3});
  }
  
  // Draws the slider and calls the ticks method
  void draw(PGraphics pg) {
    tick();

    if (isHorizontal) {
      pg.line(x - sliderLength / 2, y, x + sliderLength / 2, y);
      pg.line(x - sliderLength / 2, y, x - sliderLength / 2 + 5, y - flipped * 7);
      pg.line(x + sliderLength / 2, y, x + sliderLength / 2 - 5, y - flipped * 7);
    } else {
      pg.line(x, y - sliderLength / 2, x, y + sliderLength / 2);
      pg.line(x, y - sliderLength / 2, x + flipped * 5, y - sliderLength / 2 + 7);
      pg.line(x, y + sliderLength / 2, x + flipped * 5, y + sliderLength / 2 - 7);
    }

    pg.triangle(t1.x, t1.y, t2.x, t2.y, t3.x, t3.y);
  }
  
  // Flips the slider
  void flip() { 
    flipped *= -1;
  }
  
  // Sets clicking to true
  void mousePressed() {
    if (!clickableBounds.isOutOfBounds(mouseX, mouseY)) clicking = true;
  }
  
  // Sets clicking to false
  void mouseReleased() {
    clicking = false;
  }
  
  // Changes the triangle's position and updates the value accordingly
  void mouseDragged() {
    if (clicking && !sliderBounds.isOutOfBounds(mouseX, mouseY)) {
      if (isHorizontal) {
        value = (mouseX - (x - sliderLength / 2)) / sliderLength;
      } else {
        value = (mouseY - (y - sliderLength / 2)) / sliderLength;
      }
    }
  }
  
  // Unused
  boolean click() {
    return false;
  }
}