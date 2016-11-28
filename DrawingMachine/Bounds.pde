public class Bounds {

  private Vect2[] vertices;
  
  public Bounds(Vect2[] vertices) {
    this.vertices = vertices;
  }

  public void setVertices(Vect2[] vertices) {
    this.vertices = vertices;
  }

  public boolean isOutOfBounds(Vect2 coords) {
    Vect2 lowestPoint = new Vect2(vertices[0].x, vertices[0].y);
    Vect2 highestPoint = new Vect2(vertices[0].x, vertices[0].y);

    for (Vect2 vertex : vertices) {
      if (vertex.x < lowestPoint.x) lowestPoint.set(vertex.x, lowestPoint.y);
      else if (vertex.x > highestPoint.x) highestPoint.set(vertex.x, highestPoint.y);

      if (vertex.y < lowestPoint.y) lowestPoint.set(lowestPoint.x, vertex.y);
      else if (vertex.y > highestPoint.y) highestPoint.set(highestPoint.x, vertex.y);
    }

    if (coords.x < lowestPoint.x || coords.y < lowestPoint.y || coords.x > highestPoint.x || coords.y > highestPoint.y) return true;
    else return false;
  }

  public boolean isOutOfBounds(float x, float y) {
    return isOutOfBounds(new Vect2(x, y));
  }
}