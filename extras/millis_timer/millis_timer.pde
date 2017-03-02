int startTime = 0;
void setup() {
  size(400,400); 
  startTime = millis();
}

void draw() {
  background(0);
  fill(255);
  textSize(24);
  int now = millis() - startTime;
  int minutes = (now/1000) % 60;
  text(now / 1000, 10, 200);
}