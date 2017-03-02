PImage img;
void setup() {
  size(600, 600, P2D);
  img = loadImage("cat.jpg");
  background(0);
  strokeWeight(3);
  stroke(255);
  noFill();

  beginShape(TRIANGLE_STRIP);
  texture(img);
  for (float x = 0; x < width; x+= 50) {
    float u = map(x, 0, width, 0, img.width);
    vertex(x, 300, u, 10);
    vertex(x, 350, u, 60);
  }
  endShape();
}