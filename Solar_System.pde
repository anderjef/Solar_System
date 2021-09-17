//Jeffrey Andersen

import peasy.*; //PeasyCam

float sunRadius = 100; //radius of the sun; experimentally determined to be decent
int maxNumPlanets = 48; //maximum number of planets to spawn
float minRadius = 1; //smallest radius of a planet; experimentally determined to be decent
float minOrbitSpeed = 0.0005; //minimum angular speed of a planet; experimentally determined to be decent (slower is more boring, yet more realistic and hides crimes)
float maxOrbitSpeed = 0.055; //maximum angular speed of a planet; experimentally determined to be decent (slower is more boring, yet more realistic and hides crimes)
int childrenCap = 16; //the cap on many children planets any one planet (or star) can have
int maxDepth = 3; //how many levels of children planets a star can have; experimentally determined to be decent
float planetSpawnProbability = random(0.3, 0.7); //the chance of a planet spawning; experimentally determined to be decent (must be bounded by 0 to 1)
float parentToChildRadiusRatio = 0.5; //what fraction of the parent's radius is a child capped to; to prevent planets from being too near their parents' size; experimentally determined to be decent
boolean drawBackground = true; //drawing the background can be turned off for some interesting drawings
float starDeltaRotation = 0.0006; //how fast the star rotates
float xRotationMultiplier = 1, yRotationMultiplier = 2, zRotationMultiplier = 3;

Star sun; //used as a focus for the camera and as the system's source of light
int currentNumPlanets = 0; //how many planets there currently are
PeasyCam cam;

void setup() {
  size(1600, 1600, P3D);
  float distanceToCornerOfFrame = sqrt(width * width + height * height) / 2;
  float maxR = distanceToCornerOfFrame; //the furthest possible distance from the start that (the center of) a child planet can spawn
  noStroke();
  sun = new Star(sunRadius, childrenCap, maxR);
  cam = new PeasyCam(this, distanceToCornerOfFrame); //camera that allows for mouse control
  //if (currentNumPlanets == 0) { println("Sorry, this random generation produced no planets. Try again to get something more exciting."); } //deprecated for being rare enough (1/(childrenCap * 1/(planetSpawnProbability lower bound)) chance) to not warrant and being the only use of the command prompt
}

void draw() {
  if (drawBackground) {
    background(0);
  }
  sun.show();
  sun.update();
}

void keyPressed() { //pressing the spacebar toggles whether the background is drawn or not
  if (keyCode == ' ') {
    drawBackground = !drawBackground;
  }
}
