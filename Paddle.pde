class Paddle extends Movement {
  public Paddle(float x, float y) {
    super(x, y); 
    xc = x - wid/2;
    yc = y - hei/2;
    wid = 15;
    hei = 90;
    velocity = 5;
  }

  void act() { 
    fill(255);
    drawRect();
    //arrowMover(5);
    yLock(hei/2);
    xc = x - wid/2;
    yc = y - hei/2;
  }
}
