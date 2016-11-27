public class Text extends Input {
  
  protected float x, y;
  
  protected String text;
  protected float textWidth, textHeight;
  
  protected Bounds clickableBounds;
  
  protected boolean centerX, centerY;
  protected boolean selected;
  
  public Text(String text, float x, float y) {
    setText(text);
    textWidth = textWidth(text);
    textHeight = textAscent() + textDescent();
    
    setCoordinates(x, y);
    
    clickableBounds = new Bounds(new Vect2[]{new Vect2(x, y), new Vect2(x + textWidth, y), new Vect2(x + textWidth, y - textHeight), new Vect2(x, y - textHeight)});
  }
  
  public void draw(PGraphics pg) {
    pg.text(text, x, y);
  }
  
  public void centerX() {
    centerX = !centerX;
    setCoordinates(x, y);
  }
  
  public void centerY() {
    centerY = !centerY;
    setCoordinates(x, y);
  }
  
  public void setCoordinates(float x, float y) {
    this.x = x;
    this.y = y;
    if (centerX) this.x -= textWidth / 2;
    if (centerY) this.y += textHeight / 2;
  }
  
  public void setText(String text) {
    this.text = text;
  }
  
  public String getText() {
    return text;
  }
  
  public void mousePressed() {
  }
  public void mouseReleased() {
  }
  public void mouseDragged() {
  }
  public void mouseClicked() {
    if (selected && clickableBounds.isOutOfBounds(mouseX, mouseY)) selected = false;
    if (!clickableBounds.isOutOfBounds(mouseX, mouseY)) selected = true;
    println(selected);
  }
}