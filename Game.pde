float depth = 2000;
float rotateY, rotateX, rotateZ = 0;
int plateWidth, plateDepth = 300;
int plateHeight = 10;

Mover ball;

void setup() {
  size(800, 800, P3D);
  ball = new Mover();
}

void draw() {
  camera(0, 0, 400, 0, 0, 0, 0, 1, 0);
  directionalLight(50, 100, 125, 0, -1, 0);
  ambientLight(102, 102, 102);
  background(200);

  rotateX(rotateX);
  rotateY(rotateY);
  rotateZ(rotateZ);

  box(plateWidth, plateHeight, plateDepth);

  ball.update();
  ball.checkEdges();
  ball.display();
}
  
void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      rotateY += 1;
    } else if (keyCode == RIGHT) {
      rotateY -= 1;
    }
  }
}
void mouseDragged() {
  rotateX = constrain(rotateX+(pmouseY-mouseY)/128.0, -PI/3, PI/3);
  rotateZ = constrain(rotateZ+(mouseX-pmouseX)/128.0, -PI/3, PI/3);
}

