//started 09/16/19
//inspiration: https://www.youtube.com/watch?v=l8SiJ-RmeHU, https://www.youtube.com/watch?v=dncudkelNxw, https://www.youtube.com/watch?v=FGAwi7wpU8c
//generates a random solar system (from some arbitrary values) and simulates the system

Star sun; //used as a focus for the camera and as the system's source of light
float sunRadius = 100; //radius of the sun
ArrayList<Planet> planets;
float numPlanets = 0; //number of planets to spawn
float minR = 0; //smallest radius of a planet
float maxR = 0; //largest radius of a planet
float spawnSpan = 0; //furthest possible distance from the sun that a planet can spawn
float despawnSpan = 0; //distance away from the sun that planets despawn

void setup() {
  size(800, 800, P3D);
  sun = new Star(sunRadius);
  planets = new ArrayList<Planet>();
}

void draw() {
  background(0);
  sun.show();
  for (int i = 0; i < planets.size(); ++i) {
    planets.get(i).show();
  }
  for (int i = 0; i < 0; ++i) {
    for (int j = 0; j < 0; ++j) {
      for (int k = 0; k < 0; ++k) {
        if (sqrt(i * i + j * j + k * k) < 80) {
          //pointLight(255, 255, 255, i, j, k);
        }
      }
    }
  }
  //pointLight(255, 255, 255, 0, 0, 0);
}
