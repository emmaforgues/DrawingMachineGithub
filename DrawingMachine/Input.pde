// Abstract class used as a canvas for any other class that will require mouse input
abstract class Input {
  
  // Array of Runnable objects used to run actions everytime this input object is clicked
  ArrayList<Runnable> onClick;
  
  // Contructor
  Input() {
    // Instantiate this array
    onClick = new ArrayList<Runnable>();
    
    // Pushes itself in the inputToProcess ArrayList in the DrawingMachine class
    // This list is used to call every input related method of every instance of the Input class
        // when the built-in classes of the same names are being called in the main Class of the project
    DrawingMachine.inputToProcess.add(this);
  }
  
  // Adds a Runnable object to the onClick Array
  void addOnClickRunnable(Runnable run) {
    onClick.add(run);
  }
  
  // Called everytime the mouse is clicked
  void mouseClicked() {
    // This checks if the click method returns true (meaning the click happened in the bounds of this input object)
      // If it returns true it then proceeds to run every Runnable object in the onClick Array
    if (click()) for (Runnable run : onClick) run.run();
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
  // Called by the mouseClicked method everytime the mouse is clicked anywhere on the screen
    // This should return true only if the mouse click happened inside the bounds of this input object
  abstract boolean click();
}