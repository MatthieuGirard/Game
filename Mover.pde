class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  int tailleSphere;
  float gravity;
  float frottement;

  Mover() {
    location = new PVector(0, 0, 0);
    velocity = new PVector(0, 0, 0);
    acceleration = new PVector(0, 0, 0);
    tailleSphere = 20;
    gravity = 10;
    frottement = 1;
  }
  void update() {

    float frictionMagnitude = 0.1;
    PVector frein = velocity.get();
    frein.normalize();
    frein.mult(-frictionMagnitude);

    acceleration.set(gravity*sin(rotateZ), 0, gravity*sin(-rotateX));
    acceleration.add(frein);
    velocity.add(acceleration);
    location.add(velocity);
  }
  void display() {
    pushMatrix();
    noStroke();
    translate(0, -(tailleSphere + plateHeight/2), 0);
    translate(location.x, location.y, location.z);
    sphere(tailleSphere);

    popMatrix();
  }
  void checkEdges() {
    int limitX = plateWidth/2;
    int limitZ = plateDepth/2;
    if (location.x < -limitX || location.x > limitX) {
      velocity.x *= -1;
      location.x = constrain(location.x, -limitX, limitX);
    }
    if (location.z < -limitZ || location.z > limitZ) {
      velocity.z *= -1; 
      location.z = constrain(location.z, -limitZ, limitZ);
    }
  }
}

