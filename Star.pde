//Jeffrey Andersen

class Star {
  float theta = random(TWO_PI); //rotation angle
  float r; //size of star
  float[] clr = { random(255), random(255), random(255) }; //color
  ArrayList<Planet> childrenPlanets = new ArrayList<Planet>();
  PImage starTexture;
  PShape sphereShape;
  int depthInHierarchy = 0;

  Star(float _r, int maxNumChildren, float maxR) {
    r = _r;
    starTexture = loadImage("starTexture.jpg"); //future consideration: somewhat awkwardly, the light the star currently shines could be a different color than the star's current Sun texture
    sphereShape = createShape(SPHERE, r);
    sphereShape.setTexture(starTexture);
    if (depthInHierarchy <= maxDepth) {
      int numChildren = min(int(random(maxNumChildren) * planetSpawnProbability), maxNumPlanets - currentNumPlanets);
      currentNumPlanets += numChildren;
      for (int i = 0; i < numChildren; i++) {
        childrenPlanets.add(new Planet(r, maxR, depthInHierarchy));
      }
    }
  }

  void update() {
    theta += starDeltaRotation;
    for (Planet p : childrenPlanets) {
      p.update();
    }
  }

  void show() {
    fill(clr[0], clr[1], clr[2]);
    //sphere(r); //deprecated for using an image
    pushMatrix();
    rotateX(xRotationMultiplier * theta);
    rotateY(yRotationMultiplier * theta);
    rotateZ(zRotationMultiplier * theta);
    shape(sphereShape);
    for (int brightness = 2; brightness < 16; brightness *= brightness) { //if the star is too dark, try brightening it up to minimize black-star (boring) cases
      if (clr[0] + clr[1] + clr[2] < brightness) {
        clr[0] *= clr[0];
        clr[1] *= clr[1];
        clr[2] *= clr[2];
      }
    }
    for (int powerOfTwo = 8; powerOfTwo > 2; powerOfTwo /= 2) { //if the star is too dark, try brightening it up to minimize black-star (boring) cases
      if (clr[0] + clr[1] + clr[2] < 16 * powerOfTwo) {
        clr[0] *= powerOfTwo;
        clr[1] *= powerOfTwo;
        clr[2] *= powerOfTwo;
      }
    }
    if (clr[0] + clr[1] + clr[2] < 256) { //if the star is still fairly dark, try brightening it up to minimize black-star (boring) cases
      clr[0] = 255; //stars like to be more red
      clr[1] = 127;
      clr[2] = 127;
    }
    lightFalloff(0.04, 0, 0); //falloff rate experimentally determined to be decent
    float ambientBrightnessMultiplier = 5 / 255.0; //experimentally determined to be decent
    ambientLight(max(sun.clr[0] * ambientBrightnessMultiplier, 8), max(sun.clr[1] * ambientBrightnessMultiplier, 4), max(sun.clr[2] * ambientBrightnessMultiplier, 4)); //ambient light is not as realistic, but the system looks more interesting with it; ambient light is slightly whitened relative to star's color to show off the planets' colors
    pointLight(clr[0], clr[1], clr[2], 0, 0, 0);
    popMatrix();
    for (Planet p : childrenPlanets) {
      p.show();
    }
  }
}
