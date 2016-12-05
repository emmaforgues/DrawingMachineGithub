abstract class Input {
  
  ArrayList<Runnable> onClick;
  
  Input() {
    onClick = new ArrayList<Runnable>();
    
    DrawingMachine.inputToProcess.add(this);
  }
  
  void addOnClickRunnable(Runnable run) {
    onClick.add(run);
  }
  
  void mouseClicked() {
    if (click()) for (Runnable run : onClick) run.run();
  }

  abstract void draw(PGraphics pg);

  abstract void mousePressed();
  abstract void mouseReleased();
  abstract void mouseDragged();
  abstract boolean click();
}