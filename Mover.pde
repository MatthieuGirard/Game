    class Mover {
      PVector location;
      PVector velocity;
      PVector acceleration;
    
      Mover() {
        location = new PVector(0, 0, 0);
        velocity = new PVector(0, 0, 0);
        acceleration = new PVector(0, 0, 0);
      }
      void update() {
    
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
          translate(0, -(tailleSphere + plateHeight/2), 0);
          translate(location.x, location.y, location.z);
          sphere(tailleSphere);
          noStroke();
        popMatrix();
      }
      void displayShift() {
        pushMatrix();
          translate(location.x, location.z);
          noStroke();
          sphere(tailleSphere);
        popMatrix();
      }
      void checkEdges() {
        int limitX = plateWidth/2;
        int limitZ = plateDepth/2;
        if (location.x < -limitX || location.x > limitX) {      
          velocity.x *= -1;
          location.x = constrain(location.x, -limitX, limitX);
          
          lastHitScore -= velocity.mag();
          totalScore += lastHitScore;
        }
        if (location.z < -limitZ || location.z > limitZ) {
          velocity.z *= -1; 
          location.z = constrain(location.z, -limitZ, limitZ);
          
          lastHitScore -= velocity.mag();
          totalScore += lastHitScore;
        }
      }
      void checkCylinderCollision() {
        for (int i = 0; i < cylinders.size(); i++) {
          PVector normal = new PVector(location.x - cylinders.get(i).positionX, 0, location.z - cylinders.get(i).positionZ);
    
          float distBallCylinder = tailleSphere+cylinderBaseSize;
          if (normal.magSq() <= sq(distBallCylinder)) {
            normal.normalize();
            PVector normalCopy = normal.get();
            normal.mult(2 * velocity.dot(normal));
            velocity.sub(normal);
            
            location.x = cylinders.get(i).positionX + normalCopy.x * distBallCylinder;
            location.z = cylinders.get(i).positionZ + normalCopy.z * distBallCylinder;
            
            lastHitScore = velocity.mag();
            totalScore += lastHitScore;
          }
        }
      }
    }

