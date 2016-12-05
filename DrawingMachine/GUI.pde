// Class containing all the GUI (Graphical User Interface) elements
// Used to keep the code clean and easy to read
class GUI {

  HashMap<String, Button> buttons;


  Slider left_lineLengthSlider, right_lineLengthSlider;

  GUI() {
    buttons = new HashMap<String, Button>();

    buttons.put("help", new Button(width - 56, 56, "help", "closeHelp"));

    buttons.put("pause", new Button(width / 7, height - 56, "pause", "play"));

    buttons.put("clear", new Button(width * 2 / 7, height - 56, "reset"));
    buttons.get("clear").addOnClickRunnable(new Runnable() {
      void run() {
        drawing.clear();
      }
    }
    );

    buttons.put("hideUI", new Button(width * 3 / 7, height - 56, "hideUI"));

    buttons.put("saveFrame", new Button(width  * 4/ 7, height - 56, "saveFrame"));
    buttons.get("saveFrame").addOnClickRunnable(new Runnable() {
      void run() {
        drawing.save("screenPrint.jpg");
      }
    }
    );

    buttons.put("rotationSpeed", new Button(width * 5 / 7, height - 56, "rotation"));
    buttons.put("translationSpeed", new Button(width * 6 / 7, height - 56, "translation"));

    // Left line length slider
    left_lineLengthSlider = new Slider(50, 200, 100, false, (drawers[0].lineLength - 250) / 100);

    // Right line length slider
    right_lineLengthSlider = new Slider(width - 50, 200, 100, false, (drawers[1].lineLength - 250) / 100);
    right_lineLengthSlider.flip();
  }

  void update() {
    drawers[0].lineLength = 250 + 100 * (1 - left_lineLengthSlider.value);
    drawers[1].lineLength = 250 + 100 * (1 - right_lineLengthSlider.value);
  }

  void draw(PGraphics pg) {
    for (Button button : buttons.values()) button.draw(pg);

    left_lineLengthSlider.draw(pg);
    right_lineLengthSlider.draw(pg);

    if (buttons.get("help").clicked) {
      pg.fill(255);
      pg.rect(30, 30, width - 60, height - 60);

      pg.image(buttons.get("help").clickedImg, buttons.get("help").x - buttons.get("help").clickedImg.width / 2, buttons.get("help").y - buttons.get("help").clickedImg.height / 2);

      pg.fill(0);
      pg.textSize(24);
      pg.textAlign(CENTER, CENTER);
      
      pg.text("GUI guide", width / 2, 50);
      pg.textSize(14);
      pg.text("The machine automatically draws patterns with or without the user's help.", width / 2, 85);
      pg.text("The user can interact with the machine through specific commands.", width / 2, 100);
      
      pg.textSize(18);
      pg.textAlign(LEFT, CENTER);

      pg.image(buttons.get("pause").inverted, 60, (height - 60) * 2 / 8);
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