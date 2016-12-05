// Class used to  create buttons from images
class Button extends Input {
  
  // Images used for this button
    // img : normal image
    // clickedImg : normal image when the button has been clicked
    // overImg : image when the mouse is hovering over the button
    // overClickedImage : image when the mouse is hovering over the button that has been clicked
    // inverted : inverted image used to put on a white background
  PImage img, clickedImg, overImg, overClickedImg, inverted;
  
  // Button's center postion
  float x, y;
  
  // True when the button has been clicked
    // Switches everytime the button is clicked
  boolean clicked;
  
  // True when the mouse is hovering over the button
  boolean mouseEntered;
  
  // Constructor
    // Requires a position and a file name for the image used
    // fileName : file name for the image without .png
  Button(float x, float y, String fileName) {
    // Calls the super-class constructor
    super();
    
    // Sets the position
    this.x = x;
    this.y = y;
    
    // Loads the image using the file name
    img = loadImage("resources/" + fileName + ".png");
    // Creates the overImg using a copy of the normal image and blurring it
    overImg = img.copy();
    overImg.filter(BLUR);
    
    // Load the inverted image
    inverted = loadImage("resources/" + fileName + "Inverted.png");
    
    // Initialize the clicked image
    clickedImg = img;
    // Create the over clicked image using a copy of the clicked image and blurring it
    overClickedImg = clickedImg.copy();
    overClickedImg.filter(BLUR);
  }
  
  // Alternate constructor that specifies the clicked image file name
  Button(float x, float y, String fileName, String clickedFileName) {
    this(x, y, fileName);
    setClickedImage(clickedFileName);
  }
  
  // Sets the clicked image using a file name
  void setClickedImage(String fileName) {
    // Load the clicked image
    clickedImg = loadImage("resources/" + fileName + ".png");
    // Create the over clicked image using a copy of the clicked image and blurring it
    overClickedImg = clickedImg.copy();
    overClickedImg.filter(BLUR);
  }
  
  // Called every update (60 times per second)
  void update() {
    // Checks if the mouse is over the button
      // If true, it sets mouseEntered to true
    if (pointIsOver(mouseX, mouseY) && !mouseEntered) mouseEntered = true;
    // Checks if the mouse has left the button
      // If true, it sets mouseEntered to false
    else if (!pointIsOver(mouseX, mouseY) && mouseEntered) mouseEntered = false;
  }
  
  // Draw method (60 times per second)
  void draw(PGraphics pg) {
    // Calls the update method
    update();
    
    // Checks if the button is clicked or not and draws the appropriate image on the PGraphics layer
      // This also checks if the mouse is hovering the button so that it draws the appropriate image
    if (clicked) {
      if (mouseEntered) pg.image(overClickedImg, x - overClickedImg.width / 2, y - overClickedImg.height / 2);
      else pg.image(clickedImg, x - clickedImg.width / 2, y - clickedImg.height / 2);
    } else {
      if (mouseEntered) pg.image(overImg, x - overImg.width / 2, y - overImg.height / 2);
      else pg.image(img, x - img.width / 2, y - img.height / 2);
    }
  }
  
  // Utility method that returns true if the given point is over the button
  boolean pointIsOver(float x, float y) {
    if (sqrt(sq(this.x - x) + sq(this.y - y)) < img.width / 2) return true;
    else return false;
  }
  
  // Unused
  void mousePressed() {
  }
  
  // Unused
  void mouseReleased() {
  }
  
  // Unused
  void mouseDragged() {
  }
  
  // Returns true if the mouse is over the button
    // switches the clicked variable
  boolean click() {
    if (pointIsOver(mouseX, mouseY)) {
      clicked = !clicked;
      return true;
    } else return false;
  }
}