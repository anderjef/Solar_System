class Planet {
  float r, theta = random(TWO_PI); //polar coordinates
  float radius; //size of planet
  float[] clr = {random(255), random(255), random(255)};
  float orbitSpeed;
  ArrayList<Planet> childrenPlanets = new ArrayList<Planet>();
  int myDepth;

  Planet(float parentRadius, float maxR, int parentDepth) {
    radius = max(random(parentRadius * parentToChildRadiusRatio), minRadius); //children take a radius no greater than their parent's
    r = min(random(2 * radius + parentRadius, maxR - parentRadius), maxR - parentRadius);
    float inverseOfPlanetSize = 1 - radius / sunRadius;
    int flipOrbitMultiplier = int(random(1) > 0.08 * inverseOfPlanetSize * myDepth) * -2 + 1; //a small chance of retrograde (here clockwise) orbits to approximate the Milky Way proportion and our solar system's direction when observed from above; inversely proportional to planet size and depth to reduce the chance of planets unrealistically colliding/merging
    float orbitRMultiplier = 1 * pow(1 - r / maxR, 2); //speed is inversely proportional to distance from the parent celestial body (to be more realistic)
    float orbitRadiusMultiplier = 0.5 * pow(inverseOfPlanetSize, 2); //orbit speed is slightly inversely proportional to size (to be more realistic and to reduce the chance of planets unrealistically colliding/merging)
    myDepth = parentDepth + 1;
    float orbitDepthMultiplier = 1 * pow(myDepth, 4); //orbit speed is strongly proportional to planet depth (which is notably related to planet size)
    orbitSpeed = flipOrbitMultiplier * (minOrbitSpeed + random(maxOrbitSpeed - minOrbitSpeed) * orbitRadiusMultiplier * orbitRMultiplier * orbitDepthMultiplier);
    
    if (myDepth <= maxDepth) {
      int numChildren = min(int(random(childrenCap) * planetSpawnProbability), maxNumPlanets - currentNumPlanets);
      currentNumPlanets += numChildren;
      for (int i = 0; i < numChildren; ++i) {
        childrenPlanets.add(new Planet(radius, r / 2, myDepth)); //max distance from parent is divided to be more realistic, but would ideally be based on the mass ratio of the parent to grandparent
      }
    }
  }

  void update() {
    theta += orbitSpeed; //considered making the revolutions more 3D, but in reality, most are very close to being on a plane
    for (int i = 0; i < childrenPlanets.size(); ++i) {
      childrenPlanets.get(i).update();
    }
  }

  void show() {
    pushMatrix();
    fill(clr[0], clr[1], clr[2]);
    rotate(theta);
    translate(r, 0, 0);
    sphere(radius);
    for (int i = 0; i < childrenPlanets.size(); ++i) {
      childrenPlanets.get(i).show();
    }
    popMatrix();
  }
}
