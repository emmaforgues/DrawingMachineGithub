abstract class Input {

  Input() {
    DrawingMachine.inputToProcess.add(this);
  }

  abstract void draw(PGraphics pg);

  abstract void mousePressed();
  abstract void mouseReleased();
  abstract void mouseDragged();
  abstract void mouseClicked();
}