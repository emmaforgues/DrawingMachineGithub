class Button extends Input {
  
  PImage img, clickedImg, overImg, overClickedImg, inverted;
  
  float x, y;
  
  boolean clicked;
  boolean mouseEntered;
  
  Button(float x, float y, String fileName) {
    super();
    
    this.x = x;
    this.y = y;
    
    img = loadImage("resources/" + fileName + ".png");
    overImg = img.copy();
    overImg.filter(BLUR);
    
    inverted = loadImage("resources/" + fileName + "Inverted.png");
    
    clickedImg = img;
    overClickedImg = clickedImg.copy();
    overClickedImg.filter(BLUR);
  }
  
  Button(float x, float y, String fileName, String clickedFileName) {
    this(x, y, fileName);
    setClickedImage(clickedFileName);
  }
  
  void setClickedImage(String fileName) {
    clickedImg = loadImage("resources/" + fileName + ".png");
    overClickedImg = clickedImg.copy();
    overClickedImg.filter(BLUR);
  }
  
  void update() {
    if (pointIsOver(mouseX, mouseY) && !mouseEntered) mouseEntered = true;
    else if (!pointIsOver(mouseX, mouseY) && mouseEntered) mouseEntered = false;
  }
  
  void draw(PGraphics pg) {
    update();
    
    if (clicked) {
      if (mouseEntered) pg.image(overClickedImg, x - overClickedImg.width / 2, y - overClickedImg.height / 2);
      else pg.image(clickedImg, x - clickedImg.width / 2, y - clickedImg.height / 2);
    } else {
      if (mouseEntered) pg.image(overImg, x - overImg.width / 2, y - overImg.height / 2);
      else pg.image(img, x - img.width / 2, y - img.height / 2);
    }
  }
  
  boolean pointIsOver(float x, float y) {
    if (sqrt(sq(this.x - x) + sq(this.y - y)) < img.width / 2) return true;
    else return false;
  }
  
  void mousePressed() {
  }
  
  void mouseReleased() {
  }
  
  void mouseDragged() {
  }
  
  boolean click() {
    if (pointIsOver(mouseX, mouseY)) {
      clicked = !clicked;
      return true;
    } else return false;
  }
}