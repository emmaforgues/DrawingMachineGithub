
public class Drawer {
  
  public PGraphics pg;

  public float x, y;
  public float anchorX, anchorY;
  public float size;
  public float speed, horizontalSpeed;
  
  public float lineLength;
  public float lineX = width / 2, lineY = height / 2;
  
  public float angle;
  public float lx1, lx2, ly1, ly2;

  public Drawer(PGraphics pg, float x, float y, float size, float speed, float horizontalSpeed) {
    this.pg = pg;
    this.x = x;
    this.y = y;
    this.size = size;
    this.speed = speed;
    this.horizontalSpeed = horizontalSpeed;

    angle = random(TWO_PI);
    lineLength = random(175, 300);
    
    lx1 = x - size;
    lx2 = x + size;
    ly1 = y;
    ly2 = y;
  }

  public void update() {
    angle += speed;
    
    if (x + size / 2 >= lx2 || x - size / 2 <= lx1) horizontalSpeed = horizontalSpeed * (-1);
    x += horizontalSpeed;
    
    anchorX = x + cos(angle) * size / 2;
    anchorY = y + sin(angle) * size / 2;
  }

  public void draw() {
    pg.fill(0);
    pg.stroke(255);

    pg.line(lx1, ly1, lx2, ly2);
    pg.ellipse(lx1 - 5, ly1, 10, 10);
    pg.ellipse(lx2 + 5, ly2, 10, 10);

    pg.ellipse(x, y, size, size);

    pg.fill(255);
    pg.ellipse(anchorX, anchorY, 7, 7);
    
    pg.line(anchorX, anchorY, lineX, lineY);
  }
}