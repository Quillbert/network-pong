class Ball extends Movement {
  public Ball(float x, float y) {
    super(x, y);
    xc = x - radius/2;
    yc = y - radius/2;
    radius = 20;
    velocity = 4;
    course = (int)random(0, 360);
    if (course >= 225 && course <= 315) {
      course = 215;
    } else if (course >= 45 && course <= 135) {
      course = 35;
    }
  }

  void act() {
    if (startTimer > 0) {
      velocity = 0;
    }
    if (startTimer == 0) {
      velocity = 4;
    }
    drawCircle();
    move();
    yBounceCir();
    if (rectBox(paddle1)) {
      if (x > paddle1.x) {
        xBounceRandom();
        if (velocity < 9) {
          velocity += random(0, 0.2);
        }
      }
    }
    if (rectBox(paddle2)) {
      if (x < paddle2.x + paddle2.wid) {
        xBounceRandom();
        if (velocity < 9) {
          velocity += random(0, 0.2);
        }
      }
    }
    xc = x - radius/2;
    yc = y - radius/2;
    if (x < 0 - wid) {
      startTimer = 165;
      score2++;
      setPos(width/2, height/2);
    }
    if (x > width + wid) {
      startTimer = 165;
      score1++;
      setPos(width/2, height/2);
    }
  }
}
