class Cylinder {
  
  float positionX;
  float positionZ;
  

  PShape openCylinder;
  PShape fullCylinder;
  PShape topCylinder;
  
  Cylinder(float positionX, float positionZ) {
    float limitX = plateWidth/2 - cylinderBaseSize;
    float limitZ = plateDepth/2 - cylinderBaseSize;
    this.positionX = constrain(positionX, -limitX, limitX);
    this.positionZ = constrain(positionZ, -limitZ, limitZ);
    println(positionX+", "+positionZ);
  }
  
  void init() {
    stroke(0);
    float angle;
    float[] x = new float[cylinderResolution + 1];
    float[] z = new float[cylinderResolution + 1];
    //get the x and y position on a circle for all the sides
    for(int i = 0; i < x.length; i++) {
      angle = (TWO_PI / cylinderResolution) * i;
      x[i] = positionX + sin(angle) * cylinderBaseSize;
      z[i] = positionZ + cos(angle) * cylinderBaseSize;
    }
    openCylinder = createShape();
    openCylinder.beginShape(QUAD_STRIP);
    //draw the border of the cylinder
    for(int i = 0; i < x.length; i++) {
      openCylinder.vertex(x[i], -plateHeight/2, z[i]);
      openCylinder.vertex(x[i], -cylinderHeight, z[i]);
    }
    openCylinder.endShape();
    
    topCylinder = createShape();
    topCylinder.beginShape(TRIANGLE_FAN);
    topCylinder.vertex(positionX, -cylinderHeight, positionZ);
    for(int i = 0; i < x.length; i++) {
      topCylinder.vertex(x[i], -cylinderHeight, z[i]);
    }
    topCylinder.endShape();
    
    fullCylinder = createShape(GROUP);
    fullCylinder.addChild(openCylinder);
    fullCylinder.addChild(topCylinder);
  }
  void display() {
    shape(fullCylinder);
  }
}
