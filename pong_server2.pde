import processing.net.*; //<>//

ChildApplet child;
Server pong;

int bounceTimer = 0;
int startTimer = 165;
int score1 = 0;
int score2 = 0;
int timeDisplay;
int clientNum = 0;

String input;
int data[];
int id = 0;
int move = 0;

boolean paddle1up = false;
boolean paddle1down = false;
boolean paddle2down = false;
boolean paddle2up = false;

Ball ball = new Ball(300, 200);
Paddle paddle1 = new Paddle(30, 200);
Paddle paddle2 = new Paddle(570, 200);

void settings() {
  size(600, 400);
}

void setup() {
  frameRate(55);
  pong = new Server(this, 11000);
  child = new ChildApplet();
}

void draw() {
  if (paddle1up) {
    paddle1.y -= paddle1.velocity;
  }
  if (paddle1down) {
    paddle1.y += paddle1.velocity;
  }
  if (paddle2up) {
    paddle2.y -= paddle2.velocity;
  }
  if (paddle2down) {
    paddle2.y += paddle2.velocity;
  }
  input = "";
  timeDisplay = (startTimer/55) + 1;
  if (startTimer < 0) {
    timeDisplay = -1;
  }
  bounceTimer++;
  background(0); 
  Client client = pong.available();
  if (client != null) {
    input = client.readString();
    data = int(split(input, ' '));
    println(data);
    id = data[0];
    move = data[1];
    switch(id) {
    case 1:
    case 1200:
      switch(move) {
      case 1:
        paddle1up = true;
        break;
      case 2:
        paddle1down = true;
        break;
      case 3:
        paddle1up = false;
        break;
      case 4:
        paddle1down = false;
        break;
      }
      break;
    case 2:
    case 2200:
      switch(move) {
      case 1:
        paddle2up = true;
        break;
      case 2:
        paddle2down = true;
        break;
      case 3:
        paddle2up = false;
        break;
      case 4:
        paddle2down = false;
        break;
      }
      break;
    }
  }
  if (startTimer > -1 && clientNum >= 2) {
    startTimer--; 
    textSize(50);
    text(timeDisplay, width/2 -15, height/2 -100);
  }
  ball.act();
  paddle1.act();
  paddle2.act();
  textSize(23);
  text(score1, 5, 25);
  text(score2, width-20, 25);
  pong.write(
    (int)paddle1.y + " " + 
    (int)paddle2.y + " " + 
    (int)ball.x + " " + 
    (int)ball.y + " " + 
    (int)score1 + " " + 
    (int)score2 + " " + 
    (int)timeDisplay + " " +
    (int)clientNum);
}

void serverEvent(Server server, Client client) {
  clientNum++;
}

class ChildApplet extends PApplet {
  public ChildApplet() {
    super();
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }
  public void settings() {
    size(300, 200);
  }

  public void setup() {
    background(0);
    fill(255);
    textSize(20);
    text("Your IP is:", width/2-40, 20);
    textSize(40);
    text(pong.ip(), width/2 - 110, height/2 + 10);
  }
}
