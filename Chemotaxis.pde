int numberOfFish = 40;
Fish[] fish = new Fish[numberOfFish];

float foodX = -1;  // food position X
float foodY = -1;  // food position Y
boolean foodEaten = false;

void setup() {
  size(600, 400);
  // create fish
  for (int i = 0; i < numberOfFish; i++) {
    fish[i] = new Fish(random(width), random(height));
  }
}

void draw() {
  background(30, 150, 200); // blue water

  // draw food if it exists
  if (!foodEaten) {
    fill(255, 255, 0);
    ellipse(foodX, foodY, 12, 12);
  }

  int fishNearFood = 0;

  for (int i = 0; i < numberOfFish; i++) {
    if (!foodEaten) {
      fish[i].swimTo(foodX, foodY);
      if (dist(fish[i].x, fish[i].y, foodX, foodY) < 15) fishNearFood++;
    } else {
      fish[i].swimRandom();
    }
    fish[i].show();
  }

  if (fishNearFood > 2) foodEaten = true;
}

void mousePressed() {
  foodX = mouseX;
  foodY = mouseY;
  foodEaten = false;
}

// ---- Fish class ----
class Fish {
  float x, y;      // position
  float speed;     // movement speed
  float size;      // fish size
  color fishColor; // fish color

  Fish(float startX, float startY) {
    x = startX;
    y = startY;
    speed = random(1, 2);
    size = random(20, 30);
    fishColor = color(random(100, 255), random(100, 255), random(100, 255));
  }

  // move toward food
  void swimTo(float targetX, float targetY) {
    if (x < targetX) x += speed;
    if (x > targetX) x -= speed;
    if (y < targetY) y += speed;
    if (y > targetY) y -= speed;
  }

  // move randomly
  void swimRandom() {
    x += random(-1, 1);
    y += random(-1, 1);

    // wrap around screen
    if (x < 0) x = width;
    if (x > width) x = 0;
    if (y < 0) y = height;
    if (y > height) y = 0;
  }

  // draw fish
  void show() {
    fill(fishColor);
    ellipse(x, y, size, size * 0.7); // body
    triangle(x - size/2, y, x - size, y - size/4, x - size, y + size/4); // tail
    fill(255);
    ellipse(x + size/4, y - size/6, size/6, size/6); // eye
    fill(0);
    ellipse(x + size/4, y - size/6, size/12, size/12); // pupil
  }
}
