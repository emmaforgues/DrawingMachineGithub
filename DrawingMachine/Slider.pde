class Slider extends Input {

  float x, y;
  Vect2 t1, t2, t3;
  float sliderLength;
  boolean isHorizontal;
  float value;

  Bounds clickableBounds;
  Bounds sliderBounds;

  boolean clicking;
  int flipped = 1;

  Slider(float x, float y, float sliderLength, boolean isHorizontal, float value) {
    super();
    this.x = x;
    this.y = y;
    this.sliderLength = sliderLength;
    this.isHorizontal = isHorizontal;
    this.value = value;

    if (isHorizontal) {
      t1 = new Vect2(x - sliderLength / 2 + (sliderLength - 10) * value, y);
      t2 = new Vect2(x - sliderLength / 2 + 5 + (sliderLength - 10) * value, y - 7);
      t3 = new Vect2(x - sliderLength / 2 + 10 + (sliderLength - 10) * value, y);
    } else {
      t1 = new Vect2(x, y - sliderLength / 2 + (sliderLength - 10) * value);
      t2 = new Vect2(x + 7, y - sliderLength / 2 + 5 + (sliderLength - 10) * value);
      t3 = new Vect2(x, y - sliderLength / 2 + 10 + (sliderLength - 10) * value);
    }

    clickableBounds = new Bounds(new Vect2[]{t1, t2, t3});

    if (isHorizontal) sliderBounds = new Bounds(new Vect2[]{new Vect2(x - sliderLength / 2, 0), new Vect2(x + sliderLength / 2, 0), new Vect2(x + sliderLength / 2, height), new Vect2(x - sliderLength / 2, height)});
    else sliderBounds = new Bounds(new Vect2[]{new Vect2(0, y - sliderLength / 2), new Vect2(0, y + sliderLength / 2), new Vect2(width, y + sliderLength / 2), new Vect2(width, y - sliderLength / 2)});
  }

  void tick() {
    if (isHorizontal) {
      t1.set(x - sliderLength / 2 + (sliderLength - 10) * value, y);
      t2.set(x - sliderLength / 2 + 5 + (sliderLength - 10) * value, y - flipped * 7);
      t3.set(x - sliderLength / 2 + 10 + (sliderLength - 10) * value, y);
    } else {
      t1.set(x, y - sliderLength / 2 + (sliderLength - 10) * value);
      t2.set(x + flipped * 7, y - sliderLength / 2 + 5 + (sliderLength - 10) * value);
      t3.set(x, y - sliderLength / 2 + 10 + (sliderLength - 10) * value);
    }

    clickableBounds.setVertices(new Vect2[]{t1, t2, t3});
  }

  void draw(PGraphics pg) {
    tick();

    if (isHorizontal) {
      pg.line(x - sliderLength / 2, y, x + sliderLength / 2, y);
      pg.line(x - sliderLength / 2, y, x - sliderLength / 2 + 5, y - flipped * 7);
      pg.line(x + sliderLength / 2, y, x + sliderLength / 2 - 5, y - flipped * 7);
    } else {
      pg.line(x, y - sliderLength / 2, x, y + sliderLength / 2);
      pg.line(x, y - sliderLength / 2, x + flipped * 5, y - sliderLength / 2 + 7);
      pg.line(x, y + sliderLength / 2, x + flipped * 5, y + sliderLength / 2 - 7);
    }

    pg.triangle(t1.x, t1.y, t2.x, t2.y, t3.x, t3.y);
  }

  void flip() { 
    flipped *= -1;
  }

  void mousePressed() {
    if (!clickableBounds.isOutOfBounds(mouseX, mouseY)) clicking = true;
  }

  void mouseReleased() {
    clicking = false;
  }

  void mouseDragged() {
    if (clicking && !sliderBounds.isOutOfBounds(mouseX, mouseY)) {
      if (isHorizontal) {
        value = (mouseX - (x - sliderLength / 2)) / sliderLength;
      } else {
        value = (mouseY - (y - sliderLength / 2)) / sliderLength;
      }
    }
  }

  void mouseClicked() {
  }
}