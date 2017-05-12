Ball[] balls;

boolean reactionStarted;

void setup() {
  size(600, 600);
  background(0);
  reactionStarted = false;
  balls = new Ball[25];
  for (int i = 0; i < balls.length; i++) {
    balls[i] = new Ball();
    drawCircle(balls[i]);
  }
}

void draw() {
  background(0);
  for (Ball b : balls) {
    b.move();
    drawCircle(b);
    if (b.state > 0) {
      b.state--;
    }
    for (Ball collideBall : balls) {
      if (isTouching(b, collideBall) && collideBall.state > 0 && b.state == 0 && collideBall != b) {
        b.dx = 0;
        b.dy = 0;
        b.state = 100;
      }
    }
  }
}

void mouseClicked() {
  if ( !reactionStarted ) {
    balls[0].x = mouseX;
    balls[0].y = mouseY;
    balls[0].dx = 0;
    balls[0].dy = 0;
    balls[0].state = 100;
    reactionStarted = true;
  }
}

void drawCircle(Ball ball) {
  stroke(ball.c);
  fill(ball.c);
  ellipse(ball.x, ball.y, ball.rad*2 + ball.state/2, ball.rad*2 + ball.state/2);
}

void collideEffect(Ball ball) {
  for (int i = 0; i < 20; i++) {
    ball.rad++;
  }
}

boolean isTouching(Ball ball1, Ball ball2) {
  return dist(ball1.x, ball1.y, ball2.x, ball2.y) < ball1.rad + ball2.rad;
}