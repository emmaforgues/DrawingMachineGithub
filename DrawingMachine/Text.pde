class Text {

  char[] text;
  float x, y;

  Text(String text, float x, float y) {
    this.text = text.toCharArray();
    this.x = x;
    this.y = y;
  }

  void draw(PGraphics pg) {
    pg.fill(255);
    pg.textSize(18);
    pg.textAlign(CENTER);
    pg.text(text[0], x, y);

    pg.stroke(255);
    pg.noFill();
    pg.rect(x - 20 / 2, y - 19, 20, 24, 6);

    float x1 = x + 13;
    float y1 = y - 3;
    pg.fill(255);
    pg.textSize(12);
    pg.textAlign(LEFT);
    pg.text(text, 1, text.length, x1, y1);
  }
}