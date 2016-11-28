// Class containing all the GUI (Graphical User Interface) elements
// Used to keep the code clean and easy to read
class GUI {

  Text stop, clear, print, hide;

  Slider left_lineLengthSlider, right_lineLengthSlider;

  GUI() {
    stop = new Text("Stop/Start", 20, 25);
    clear = new Text("Clear", 120, 25);
    print = new Text("Print", 190, 25);
    hide = new Text("Hide Mechanism", 260, 25);

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
    stop.draw(pg);
    clear.draw(pg);
    print.draw(pg);
    hide.draw(pg);

    pg.textAlign(CENTER);
    pg.text("Translation Speed", 440, 22);
    drawKeys(pg, 440, 40, false, true, false, true);

    pg.text("Rotation Speed", 570, 22);
    drawKeys(pg, 570, 40, true, false, true, false);

    left_lineLengthSlider.draw(pg);
    right_lineLengthSlider.draw(pg);
  }

  void drawKeys(PGraphics pg, float x, float y, boolean up, boolean right, boolean down, boolean left) {
    pg.noFill();
    pg.stroke(255);
    pg.rect(x - 20 / 2, y + 1, 20, 12, 4);
    pg.rect(x - 20 / 2, y - 1, 20, -12, 4);
    pg.rect(x - 3 * 20 / 2 - 2, y - 12 / 2, 20, 12, 4);
    pg.rect(x + 20 / 2 + 2, y - 12 / 2, 20, 12, 4);

    pg.fill(255);
    if (up) pg.triangle(x - 20 / 4, y - 5, x + 20 / 4, y - 5, x, y - 9);
    if (down) pg.triangle(x - 20 / 4, y + 5, x + 20 / 4, y + 5, x, y + 9);
    if (left) pg.triangle(x - 20 / 2 - 7, y + 2, x - 20 / 2 - 7, y - 2, x - 3 * 20 / 2 + 3, y);
    if (right) pg.triangle(x + 20 / 2 + 7, y + 2, x + 20 / 2 + 7, y - 2, x + 3 * 20 / 2 - 3, y);
  }
}