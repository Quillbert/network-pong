import processing.net.*;

ChildApplet child;
Client player;

String input;
int data[];
int paddle1, paddle2, ballx, bally, score1, score2, startTime, num;
int id = -1;
int output = 0;
String out, win2;
String ip[] = {"127.0.0.1"};

boolean up = false;
boolean down = false;

void settings() {
  size(600, 400);
}

void setup() {
  ip = loadStrings("IP.txt");
  player = new Client(this, ip[0], 11000);
  child = new ChildApplet();
}

void draw() {
  background(0);
  if (player.available() > 0) {
    input = player.readString();
    data = int(split(input, ' '));
    paddle1 = data[0];
    paddle2 = data[1];
    ballx = data[2];
    bally = data[3];
    score1 = data[4];
    score2 = data[5];
    startTime = data[6];
    num = data[7];
    if (id < 0) {
      id = num;
    }
  }
  rectMode(CENTER);
  fill(255);
  rect(30, paddle1, 15, 90);
  rect(570, paddle2, 15, 90);
  ellipse(ballx, bally, 20, 20);
  textSize(23);
  text(score1, 5, 25);
  text(score2, width-20, 25);
  if (startTime < 4 && startTime > 0) {
    textSize(50);
    text(startTime, width/2 -15, height/2 -100);
  }
}

void keyPressed() {
 if(keyCode == UP && !up) {
   up = true;
   player.write(id + " " + 1);
 }
 if(keyCode == DOWN && !down) {
  down = true;
  player.write(id + " " + 2);
 }
}

void keyReleased() {
 if(keyCode == UP && up) {
  up = false;
  player.write(id + " " + 3);
 }
 if(keyCode == DOWN && down) {
  down = false;
  player.write(id + " " + 4);
 }
}

class ChildApplet extends PApplet {
  public ChildApplet() {
    super(); 
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }
  public void settings() {
    size(300, 200);
  }

  public void draw() {
    background(0);
    switch(id) {
    case 1:
    case 1200:
      win2 = "Left Paddle";
      break;
    case 2200:
    case 2:
      win2 = "Right Paddle";
      break;
    default:
      win2 = "Spectator";
      break;
    }
    textSize(20);
    fill(255);
    text("You are:", width/2 - 40, 20);
    textSize(40);
    text(win2, width/2 - 110, height/2 + 10);
  }
}
