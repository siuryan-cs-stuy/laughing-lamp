class Ball {
  
  // INSTANCE VARS
  float x;
  float y;
  float rad;
  color c;
  float dx;
  float dy;
  int state; // 0 for regular, 1 for increasing, 2 for decreasing, -1 for no longer exists (after collision)

  // default constructor
  Ball() {
    rad = 10; // radius of circle
    
    // random pos on screen
    x = random((width -  rad) + rad/2);
    y = random((height -  rad) + rad/2);
    
    // random color
    float r = random(256);
    float g = random(256);
    float b = random(256);
    c = color(r, g, b);
    
    // random velocity
    dx = random(10) - 5;
    dy = random(10) - 5;
    
    state = 0; // normal state
  }

  // moves the Ball by changing it's position using its velocity
  void move() {
    x = x + dx;
    y = y + dy;
    bounce();
  }
  
  // checks if ball is at the wall and bounces off wall if necessary
  void bounce() {
    if (x > width || x < 0) {
      dx = -dx;
    }
    if (y > height || y < 0) {
      dy = -dy;
    }
  }
}