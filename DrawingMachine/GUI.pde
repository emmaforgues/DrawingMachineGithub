// Class containing all the GUI (Graphical User Interface) elements
// Used to keep the code clean and easy to read
class GUI {
  
  // Hashmap of buttons used to store and keep track of all the buttons used in this GUI
  HashMap<String, Button> buttons;
  
  // Sliders that change the line lengths of both mechanisms
  Slider left_lineLengthSlider, right_lineLengthSlider;

  // Constructor
  GUI() {
    // Initialize the buttons Hashmap
    buttons = new HashMap<String, Button>();
    
    // Add the help button in the hashmap
    buttons.put("help", new Button(width - 56, 56, "help", "closeHelp"));
    
    // Add the pause button in the hashmap
    buttons.put("pause", new Button(width / 7, height - 56, "pause", "play"));
    
    // Add the clear button in the hashmap
    buttons.put("clear", new Button(width * 2 / 7, height - 56, "reset"));
    // Add an onClick Runnable to the clear button
    buttons.get("clear").addOnClickRunnable(new Runnable() {
      void run() {
        // This simply clears the drawing
        drawing.clear();
      }
    }
    );
    
    // Add the hideUI button to the hashmap
    buttons.put("hideUI", new Button(width * 3 / 7, height - 56, "hideUI"));
    
    // Add the saveFrame button to the hashmap
    buttons.put("saveFrame", new Button(width  * 4/ 7, height - 56, "saveFrame"));
    // Add an onClick Runnable to the saveFrame button 
    buttons.get("saveFrame").addOnClickRunnable(new Runnable() {
      void run() {
        // This saves the current frame of the drawing PGraphics layer to the sketch folder
        drawing.save("screenPrint.jpg");
      }
    }
    );

    // Add the rotationSpeed button to the hashmap
      // This button isn't used as an actual button but more as an indicator for the user
    buttons.put("rotationSpeed", new Button(width * 5 / 7, height - 56, "rotation"));
    // Add the translationSpeed button to the hashmap
      // This button isn't used as an actual button but more as an indicator for the user
    buttons.put("translationSpeed", new Button(width * 6 / 7, height - 56, "translation"));

    // Left line length slider
    left_lineLengthSlider = new Slider(50, 200, 100, false, (drawers[0].lineLength - 250) / 100);

    // Right line length slider
    right_lineLengthSlider = new Slider(width - 50, 200, 100, false, (drawers[1].lineLength - 250) / 100);
    right_lineLengthSlider.flip();
  }

  // Called everytime the draw method is ran
  void update() {
    // Updates both the drawers line lengths
    drawers[0].lineLength = 250 + 100 * (1 - left_lineLengthSlider.value);
    drawers[1].lineLength = 250 + 100 * (1 - right_lineLengthSlider.value);
  }
  
  // Called 60 times per seconds
  void draw(PGraphics pg) {
    // Draws all the buttons on the given PGraphics layer
    for (Button button : buttons.values()) button.draw(pg);
    
    // Draw both the line length sliders
    left_lineLengthSlider.draw(pg);
    right_lineLengthSlider.draw(pg);
    
    // Check if the help button is in clicked 'state'
      // If true, draw the help 'page' on the PGraphics layer
    if (buttons.get("help").clicked) {
      // Set fill color to white
      pg.fill(255);
      // Draw a rectangle that acts as a 'page' background
      pg.rect(30, 30, width - 60, height - 60);

      // Draw the help button's clicked image which acts as a close button for the help 'page'
      pg.image(buttons.get("help").clickedImg, buttons.get("help").x - buttons.get("help").clickedImg.width / 2, buttons.get("help").y - buttons.get("help").clickedImg.height / 2);
      
      // Set fill color to black
      pg.fill(0);
      // Set text size to 24
      pg.textSize(24);
      // Set the text alignment to be centered vertically and horizontally
      pg.textAlign(CENTER, CENTER);
      
      // Draw a title for this 'page'
      pg.text("GUI guide", width / 2, 50);
      // Set the text size to 14
      pg.textSize(14);
      // Draw a subtitle for this 'page'
      pg.text("The machine automatically draws patterns with or without the user's help.", width / 2, 85);
      pg.text("The user can interact with the machine through specific commands.", width / 2, 100);
      
      // Change text size
      pg.textSize(18);
      // Change text alignment
      pg.textAlign(LEFT, CENTER);
      
      // The following lines all do the same but for different buttons
      // Draws the specified button's image
      pg.image(buttons.get("pause").inverted, 60, (height - 60) * 2 / 8);
      // Draws a descriptive text of the specified button on the right side of the button's image
      pg.text("Stop/Start the mechanism", 60 + buttons.get("pause").inverted.width + 10, (height - 60) * 2 / 8 + buttons.get("pause").inverted.height / 2);

      pg.image(buttons.get("clear").inverted, 60, (height - 60) * 3 / 8);
      pg.text("Clear the drawing", 60 + buttons.get("clear").inverted.width + 10, (height - 60) * 3 / 8 + buttons.get("clear").inverted.height / 2);
      
      pg.image(buttons.get("hideUI").inverted, 60, (height - 60) * 4 / 8);
      pg.text("Hide the mechanism", 60 + buttons.get("hideUI").inverted.width + 10, (height - 60) * 4 / 8 + buttons.get("hideUI").inverted.height / 2);
      
      pg.image(buttons.get("saveFrame").inverted, 60, (height - 60) * 5 / 8);
      pg.text("Save drawing to the sketch folder", 60 + buttons.get("saveFrame").inverted.width + 10, (height - 60) * 5 / 8 + buttons.get("saveFrame").inverted.height / 2);
      
      pg.image(buttons.get("rotationSpeed").inverted, 60, (height - 60) * 6 / 8);
      pg.text("Up and Down arrow keys: Rotation speed", 60 + buttons.get("rotationSpeed").inverted.width + 10, (height - 60) * 6 / 8 + buttons.get("rotationSpeed").inverted.height / 2);
      
      pg.image(buttons.get("translationSpeed").inverted, 60, (height - 60) * 7 / 8);
      pg.text("Left and Right arrow keys: Translation speed", 60 + buttons.get("translationSpeed").inverted.width + 10, (height - 60) * 7 / 8 + buttons.get("translationSpeed").inverted.height / 2);
    }
  }
}