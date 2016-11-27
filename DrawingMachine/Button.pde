public class Button extends Input {
  
  protected float x, y;
  
  protected Shape[] activeShapes, pressedShapes;
  
  protected Bounds activeClickBounds;
  protected Bounds pressedClickBounds;
  
  protected ArrayList<Runnable> clickEvents;
  
  protected float activeColor, pressedColor;
  
  protected boolean pressed = false;
  
  public Button(float x, float y, Shape[] activeShapes, float activeColor) {
    super();
    this.x = x;
    this.y = y;
    
    this.activeShapes = activeShapes;
    pressedShapes = activeShapes;
    
    this.activeColor = activeColor;
    pressedColor = activeColor;
    
    clickEvents = new ArrayList<Runnable>();
  }
  
  public void draw(PGraphics pg) {
    if (pressed) pg.fill(pressedColor);
    else pg.fill(activeColor);
    
    for (Shape shape : (pressed) ? pressedShapes : activeShapes) {
      pg.beginShape();
      for (Vect2 vertex : shape.vertices) pg.vertex(x + vertex.x, y + vertex.y);
      pg.endShape();
    }
  }
  
  public void setActiveShapes(Shape[] shapes) {
    activeShapes = shapes;
  }
  
  public void setPressedShapes(Shape[] shapes) {
    pressedShapes = shapes;
  }
  
  public void setActiveClickBounds(Vect2[] vertices) {
    for (Vect2 vertex : vertices) vertex.set(x + vertex.x, y + vertex.y);
    activeClickBounds = new Bounds(vertices);
  }
  
  public void setPressedClickBounds(Vect2[] vertices) {
    for (Vect2 vertex : vertices) vertex.set(x + vertex.x, y + vertex.y);
    pressedClickBounds = new Bounds(vertices);
  }
  
  public void addClickEvent(Runnable run) {
    clickEvents.add(run);
  }
  
  public void mousePressed() {
  }
  public void mouseReleased() {
  }
  public void mouseDragged() {
  }
  public void mouseClicked() {
    if (!pressed && !activeClickBounds.isOutOfBounds(mouseX, mouseY)) pressed = true;
    else if (pressed && !pressedClickBounds.isOutOfBounds(mouseX, mouseY)) pressed = false;
    
    if (!clickEvents.isEmpty()) for (Runnable run : clickEvents) run.run();
  }
}