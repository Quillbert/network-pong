class Movement {
  float x, y;
  float dx = 0;
  float dy = 0;
  float velocity = 0;
  float course = 0;
  float radius = 0;
  float wid = 0;
  float hei = 0;
  float xc = 0;
  float yc = 0;

  public Movement() {
  }

  public Movement(float newX, float newY) {
    x = newX;
    y = newY;
  }

  public void move() {
    computeVector();
    x += dx;
    y += dy;
  }

  public void computeVector() {
    dx = velocity * cos(radians(course));
    dy = velocity * sin(radians(course));
  }

  public void drawCircle() {
    ellipse(x, y, radius, radius);
    hei = radius;
    wid = radius;
  }
  public void drawRect() {
    rectMode(CENTER);
    rect(x, y, wid, hei);
  }
  public boolean collusion(float x1, float y1, float x2, float y2, float dis1, float dis2) {
    if (dist(x1, y1, x2, y2) < dis1 + dis2) {
      return true;
    } else {
      return false;
    }
  }
  public void yBounceCir() {
    if (y < 0 || y > height) {
      course = course  + (0 - course)* 2;
    }
  }
  public void yBounce() {
    course = course  + (0 - course)* 2;
  }
  public void xBounce() {
    if (bounceTimer > 10)
      course = course  + (90 - course)* 2;
    bounceTimer = 0;
  }
    public void xBounceRandom() {
    if (bounceTimer > 10)
      course = random((course  + (90 - course)* 2)-8,(course  + (90 - course)* 2)+8);
    bounceTimer = 0;
  }
  public void arrowMover(float newVel) {
    if (keyPressed) {
      if (keyCode == UP) {
        course =  270;
        velocity = newVel;
        move();
      } else if (keyCode == DOWN) {
        course = 90;
        velocity = newVel;
        move();
      } else {
        velocity = 0;
      }
    }
  }
  public void yLock(float dis) {
    if (y < (0+dis)) {
      y = dis;
    } else if (y > (height - dis)) {
      y = height - dis;
    }
  }
  public void yLock(float dis, float dis2) {
    if (y < (0+dis)) {
      y = dis;
    } else if (y > (height - dis2)) {
      y = height - dis2;
    }
  }
  public boolean rectBox(Movement a) {
    boolean top = yc + hei > a.yc;
    boolean bottom = yc < a.yc +a.hei;
    boolean left = xc + wid > a.xc;
    boolean right = xc < a.xc + a.wid;
    if (top&&bottom&&left&&right) {
      return true;
    } else {
      return false;
    }
  }
  
  public void setPos(int newX, int newY) {
   x = newX;
   y = newY;
  }
}
