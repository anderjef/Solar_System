class Planet {
  float theta = random(TWO_PI); //polar coordinate
  float orbitalRadius;
  float radius; //planet radius
  float[] clr = { random(255), random(255), random(255) }; //color
  float orbitSpeed;
  ArrayList<Planet> childrenPlanets = new ArrayList<Planet>();
  int depthInHierarchy;

  Planet(float parentRadius, float maxR, int parentDepth) {
    radius = max(random(parentRadius * parentToChildRadiusRatio), minRadius); //children take a radius no greater than their parent's
    orbitalRadius = min(random(2 * radius + parentRadius, maxR - parentRadius), maxR - parentRadius);
    float inverseOfPlanetSize = 1 - radius / sunRadius;
    int flipOrbitMultiplier = int(random(1) > 0.08 * inverseOfPlanetSize * depthInHierarchy) * -2 + 1; //a small chance of retrograde (here clockwise when viewed from starting position) orbits to approximate the Milky Way proportion and our solar system's direction when observed from above (the North Pole); inversely proportional to planet size and depth to reduce the chance of planets unrealistically colliding/merging during animation
    float orbitRMultiplier = 1 * pow(1 - orbitalRadius / maxR, 2); //speed is inversely proportional to distance from the parent celestial body (to be more realistic)
    float orbitRadiusMultiplier = 0.5 * pow(inverseOfPlanetSize, 2); //orbit speed is slightly inversely proportional to size (to be more realistic and to reduce the chance of planets unrealistically colliding/merging during animation)
    depthInHierarchy = parentDepth + 1;
    float orbitDepthMultiplier = 1 * pow(depthInHierarchy, 4); //orbit speed is strongly proportional to planet depth (which is notably related to planet size)
    orbitSpeed = flipOrbitMultiplier * (minOrbitSpeed + random(maxOrbitSpeed - minOrbitSpeed) * orbitRadiusMultiplier * orbitRMultiplier * orbitDepthMultiplier);
    
    if (depthInHierarchy <= maxDepth) {
      int numChildren = min(int(random(childrenCap) * planetSpawnProbability), maxNumPlanets - currentNumPlanets);
      currentNumPlanets += numChildren;
      for (int i = 0; i < numChildren; i++) {
        childrenPlanets.add(new Planet(radius, orbitalRadius / 2, depthInHierarchy)); //max distance from parent is divided to be more realistic, but would ideally be based on the mass ratio of the parent to grandparent
      }
    }
  }

  void update() {
    theta += orbitSpeed; //considered making the revolutions more 3D, but in reality, most are very close to being on a plane
    for (Planet p : childrenPlanets) {
      p.update();
    }
  }

  void show() {
    pushMatrix();
    fill(clr[0], clr[1], clr[2]);
    rotate(theta);
    translate(orbitalRadius, 0, 0);
    sphere(radius);
    for (Planet p : childrenPlanets) {
      p.show();
    }
    popMatrix();
  }
}
