public abstract class Input {
  
  public Input() {
    DrawingMachine.inputToProcess.add(this);
  }
  
  public abstract void draw(PGraphics pg);
  
  public abstract void mousePressed();
  public abstract void mouseReleased();
  public abstract void mouseDragged();
  public abstract void mouseClicked();
}