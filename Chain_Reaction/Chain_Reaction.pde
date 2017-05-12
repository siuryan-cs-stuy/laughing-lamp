Ball[] balls;

boolean reactionStarted;

// CONSTANTS
static final int MAX_RAD = 50;
static final float dRAD = 0.5;
static final int NUM_BALLS = 100;

// runs once
void setup() {
  size(600, 600);
  background(0);
  reactionStarted = false;
  balls = new Ball[NUM_BALLS];
  for (int i = 0; i < balls.length; i++) {
    balls[i] = new Ball();
  }
}

// run loop
void draw() {
  background(0);

  // run for each ball
  for (Ball b : balls) {

    // handle ball movement and draw
    b.move();
    drawCircle(b);

    // handle state changes
    if (b.state == 1) {
      b.rad+=dRAD;
      if (b.rad > MAX_RAD) {
        b.state = 2;
      }
    } else if (b.state == 2 && b.rad > 0) {
      b.rad-=dRAD;
      if (b.rad >= 0 && b.rad < dRAD) {
        b.rad = 0;
        b.state = -1;
      }
    }

    // check for collision
    for (Ball collideBall : balls) {
      if (isTouching(b, collideBall) && collideBall.state > 0 && b.state == 0 && collideBall != b) {
        collided(b);
        break;
      }
    }
  }
}

// when mouse is pressed
void mouseClicked() {
  boolean reaction = false;
  for (Ball b : balls) {
    if (b.state > 0) {
      reaction = true;
    }
  }
  reactionStarted = reaction;
  if ( !reactionStarted ) {
    balls[0].x = mouseX;
    balls[0].y = mouseY;
    collided(balls[0]);
    reactionStarted = true;
  }
}

// changes ball physics when collides
void collided(Ball ball) {
  ball.dx = 0;
  ball.dy = 0;
  ball.state = 1;
}

// draws a circle with specified Ball attributes
void drawCircle(Ball ball) {
  stroke(ball.c);
  fill(ball.c);
  ellipse(ball.x, ball.y, ball.rad*2, ball.rad*2);
}

// returns whether two Balls are touching
boolean isTouching(Ball ball1, Ball ball2) {
  return dist(ball1.x, ball1.y, ball2.x, ball2.y) < ball1.rad + ball2.rad && ball1.rad > 0 && ball2.rad > 0;
}