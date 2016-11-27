public class Slider extends Input {
  
  protected float x, y;
  protected Vect2 t1, t2, t3;
  protected float length;
  protected boolean isHorizontal;
  protected float value;
  
  protected Bounds clickableBounds;
  protected Bounds sliderBounds;

  protected boolean clicking;
  protected int flipped = 1;

  public Slider(float x, float y, float length, boolean isHorizontal, float value) {
    super();
    this.x = x;
    this.y = y;
    this.length = length;
    this.isHorizontal = isHorizontal;
    this.value = value;

    if (isHorizontal) {
      t1 = new Vect2(x - length / 2 + (length - 10) * value, y);
      t2 = new Vect2(x - length / 2 + 5 + (length - 10) * value, y - 7);
      t3 = new Vect2(x - length / 2 + 10 + (length - 10) * value, y);
    } else {
      t1 = new Vect2(x, y - length / 2 + (length - 10) * value);
      t2 = new Vect2(x + 7, y - length / 2 + 5 + (length - 10) * value);
      t3 = new Vect2(x, y - length / 2 + 10 + (length - 10) * value);
    }

    clickableBounds = new Bounds(new Vect2[]{t1, t2, t3});

    if (isHorizontal) sliderBounds = new Bounds(new Vect2[]{new Vect2(x - length / 2, 0), new Vect2(x + length / 2, 0), new Vect2(x + length / 2, height), new Vect2(x - length / 2, height)});
    else sliderBounds = new Bounds(new Vect2[]{new Vect2(0, y - length / 2), new Vect2(0, y + length / 2), new Vect2(width, y + length / 2), new Vect2(width, y - length / 2)});
  }

  public void tick() {
    if (isHorizontal) {
      t1.set(x - length / 2 + (length - 10) * value, y);
      t2.set(x - length / 2 + 5 + (length - 10) * value, y - flipped * 7);
      t3.set(x - length / 2 + 10 + (length - 10) * value, y);
    } else {
      t1.set(x, y - length / 2 + (length - 10) * value);
      t2.set(x + flipped * 7, y - length / 2 + 5 + (length - 10) * value);
      t3.set(x, y - length / 2 + 10 + (length - 10) * value);
    }

    clickableBounds.setVertices(new Vect2[]{t1, t2, t3});
  }

  public void draw(PGraphics pg) {
    tick();

    if (isHorizontal) {
      pg.line(x - length / 2, y, x + length / 2, y);
      pg.line(x - length / 2, y, x - length / 2 + 5, y - flipped * 7);
      pg.line(x + length / 2, y, x + length / 2 - 5, y - flipped * 7);
    } else {
      pg.line(x, y - length / 2, x, y + length / 2);
      pg.line(x, y - length / 2, x + flipped * 5, y - length / 2 + 7);
      pg.line(x, y + length / 2, x + flipped * 5, y + length / 2 - 7);
    }

    pg.triangle(t1.x, t1.y, t2.x, t2.y, t3.x, t3.y);
  }
  
  public void flip() { flipped *= -1; }

  public void mousePressed() {
    if (!clickableBounds.isOutOfBounds(mouseX, mouseY)) clicking = true;
  }

  public void mouseReleased() {
    clicking = false;
  }

  public void mouseDragged() {
    if (clicking && !sliderBounds.isOutOfBounds(mouseX, mouseY)) {
      if (isHorizontal) {
        value = (mouseX - (x - length / 2)) / length;
      } else {
        value = (mouseY - (y - length / 2)) / length;
      }
    }
  }

  public void mouseClicked() {
  }
}