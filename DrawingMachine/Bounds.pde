// This class creates virtual bounds that can be used to check wheter a given point is inside these bounds
// This class includes both the bounds and the methods used to check if a point is inside the bounds
class Bounds {

  // Array of vectors representing all the corners (coordinates of the corners) of this Bounds object
  Vect2[] vertices;

  // Constructor
  // Takes only 1 parameter, which is an array of vectors representing the corners (coordinates)
  Bounds(Vect2[] vertices) {
    this.vertices = vertices;
  }

  // This method is used to set the corners of this Bounds object to a new array of vectors
  // Can be used to update bounds if the object they cover is moving or changing shape
  void setVertices(Vect2[] vertices) {
    this.vertices = vertices;
  }

  // Method used to calculate whether a point (coordinates) is inside the bounds
  // Note that this method is still being tested and doesn't work for all shapes
  // Returns false if inside the bounds and true if outside the bounds
  // Parameters: coords represents the coordinates of the point that is tested for being in or out of bounds
  boolean isOutOfBounds(Vect2 coords) {
    // This vector is used to store the value of the left most and highest (<x, <y) point of the bounds
    Vect2 lowestPoint = new Vect2(vertices[0].x, vertices[0].y);
    // This vector is used to store the value of the right most and lowest (>x, >y) point of the bounds
    Vect2 highestPoint = new Vect2(vertices[0].x, vertices[0].y);

    // For loop going through all the points in the bounds vertices (corners)
    // Stores the values of the lowest point and highest point in the 2 variable created above
    for (Vect2 vertex : vertices) {
      if (vertex.x < lowestPoint.x) lowestPoint.set(vertex.x, lowestPoint.y);
      else if (vertex.x > highestPoint.x) highestPoint.set(vertex.x, highestPoint.y);

      if (vertex.y < lowestPoint.y) lowestPoint.set(lowestPoint.x, vertex.y);
      else if (vertex.y > highestPoint.y) highestPoint.set(highestPoint.x, vertex.y);
    }

    // Checks whether the given point is in or out of bounds and returns true or false accordingly
    // This simply checks whether the given point's x and y values are higher than the lowest point and still lower than the highest point
    if (coords.x < lowestPoint.x || coords.y < lowestPoint.y || coords.x > highestPoint.x || coords.y > highestPoint.y) return true;
    else return false;
  }
  
  // Utility method that calls the other method with the same name
  // Takes two float parameters instead of a single vector
  // Creates the necessary vector for the other method and calls it with the said vector
  boolean isOutOfBounds(float x, float y) {
    return isOutOfBounds(new Vect2(x, y));
  }
}
