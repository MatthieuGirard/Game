float rotateY, rotateX, rotateZ = 0;

PVector camera = new PVector(0, 0, 400);

int plateWidth = 400;
int plateDepth = 400;
int plateHeight = 10;

int tailleSphere = 20;
float gravity = 0.3;
float frictionMagnitude = 0.05;

float cylinderBaseSize = 20;
float cylinderHeight = 40;
int cylinderResolution = 40;

boolean cameraTop = false;
ArrayList<Cylinder> cylinders;

PGraphics bottomRectangle;
PGraphics topView;
PGraphics scoreBoard;

float totalScore;
float lastHitScore;

Mover ball;

void setup() {
  size(800, 800, P3D);
  ball = new Mover();
  cylinders = new ArrayList();
  
  bottomRectangle = createGraphics(width, 150, P2D);
  topView = createGraphics(120, 120, P2D);
  scoreBoard = createGraphics(100, 130, P2D);
  
  totalScore = 0;
  lastHitScore = 0;
}

void draw() {
  
  directionalLight(50, 100, 125, 0, 1, 0);
  ambientLight(102, 102, 102);
  background(200);
  
  pushMatrix();
  translate(width/2, height/2);
  if (cameraTop) rotateX(-PI/2);

  if (!cameraTop) {
    rotateX(rotateX);
    rotateY(rotateY);
    rotateZ(rotateZ);
  }
  noStroke();
  box(plateWidth, plateHeight, plateDepth);
  drawBall();
  for (int i = 0; i < cylinders.size(); i++) {    
    cylinders.get(i).display();
  }
  popMatrix();
  
  noLights();
  drawBottomRectangle();
  drawTopView();
  drawScoreBoard();
  
}

void drawBall() {
    if (!cameraTop) ball.update();
  ball.checkEdges();
  ball.checkCylinderCollision();
  ball.display();
}

void drawBottomRectangle() {
  bottomRectangle.beginDraw();
  bottomRectangle.background(255, 0, 255);
  bottomRectangle.endDraw();
  image(bottomRectangle, 0, height - bottomRectangle.height);
}

void drawTopView() {
  topView.beginDraw();
  topView.noStroke();
  topView.translate(topView.width/2, topView.height/2);
  topView.background(0, 0, 200);
  topView.fill(255, 0, 0);
  topView.ellipse(mapPlateTopView(ball.location.x, true), mapPlateTopView(ball.location.z, false), 10, 10);
  
  topView.fill(255);
  for (int i = 0; i < cylinders.size(); i++) topView.ellipse(mapPlateTopView(cylinders.get(i).positionX, true), mapPlateTopView(cylinders.get(i).positionZ, false), 15, 15);
  topView.endDraw();
  image(topView, 15, height - bottomRectangle.height + 15);
}

void drawScoreBoard() {
  scoreBoard.beginDraw();
  scoreBoard.background(255, 0, 255);
  scoreBoard.stroke(255);
  scoreBoard.strokeWeight(2);
  scoreBoard.line(0, 0, scoreBoard.width, 0);
  scoreBoard.line(scoreBoard.width, 0, scoreBoard.width, scoreBoard.height);
  scoreBoard.line(0, 0, 0, scoreBoard.height);
  scoreBoard.line(0, scoreBoard.height, scoreBoard.width, scoreBoard.height);
  
  scoreBoard.fill(0);
  scoreBoard.text("Total Score:", 10, 20);
  scoreBoard.text(totalScore, 15, 35);  
  
  scoreBoard.text("Velocity:", 10, 60);
  scoreBoard.text(ball.velocity.mag(), 15, 75);
  
  scoreBoard.text("Last Score:", 10, 100);
  scoreBoard.text(lastHitScore, 15, 115);   
  
  scoreBoard.endDraw();
  image(scoreBoard, 35 + topView.width, height - bottomRectangle.height + 10);
}

float mapPlateTopView(float position, boolean inWidth) {
  if (inWidth) return map(position, -plateWidth/2, plateWidth/2, -topView.width/2, topView.width/2);
  else return map(position, -plateDepth/2, plateDepth/2, -topView.height/2, topView.height/2);
}
  
void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      rotateY += 1;
    } else if (keyCode == RIGHT) {
      rotateY -= 1;
    }
    else if (keyCode == SHIFT) {
      cameraTop = true;
    }
  }
}
void keyReleased() {
  if(key == CODED) {
    if (keyCode == SHIFT) {
      cameraTop = false;
    }
  }
}
void mouseDragged() {
  rotateX = constrain(rotateX+(pmouseY-mouseY)/128.0, -PI/3, PI/3);
  rotateZ = constrain(rotateZ+(mouseX-pmouseX)/128.0, -PI/3, PI/3);
}
void mousePressed() {
  if (cameraTop) {
    float positionX = mouseX - width/2.0;
    float positionZ = mouseY - height/2.0;
    if (positionX >= -plateWidth/2 && positionX <= plateWidth/2) {
      if (positionZ >= -plateDepth/2 && positionZ <= plateDepth/2) {
        Cylinder newCylinder = new Cylinder(positionX, positionZ);
        newCylinder.init();
        cylinders.add(newCylinder);
      }
    }
  }
}
  

