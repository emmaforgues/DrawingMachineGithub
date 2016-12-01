// Abstract class used as a canvas for any other class that will require mouse input
abstract class Input {

  // Contructor
  Input() {
    // Pushes itself in the inputToProcess ArrayList in the DrawingMachine class
    // This list is used to call every input related method of every instance of the Input class
        // when the built-in classes of the same names are being called in the main Class of the project
    DrawingMachine.inputToProcess.add(this);
  }
  
  // This is the same as the draw method but takes a PGraphics parameter
  // This PGraphics object is what makes it possible to draw on different layers
  abstract void draw(PGraphics pg);

  // Called when the mouse is pressed
  abstract void mousePressed();
  // Called when the mouse is released (after mousePressed and mouseDragged)
  abstract void mouseReleased();
  // Called when the mouse is dragged (after mousePressed but before mouseReleased)
  abstract void mouseDragged();
  // Called when the mouse is clicked (after moussPressed and mouseReleased)
  abstract void mouseClicked();
}
