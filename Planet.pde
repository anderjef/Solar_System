class Planet {
  //float theta = random(2 * PI); //polar coordinate
  //float deltaTheta;
  float r; //polar coordinate
  float radius; //size of planet
  float[] clr = {random(255), random(255), random(255)};
  Planet[] planets;
  float mass = 0; //FIXME: setting limits?
  
  Planet(float _r) {
    radius = random(minR, maxR);
    r = random(radius + _r, spawnSpan);
  }
  
  void update() {
    
  }
  
  void show() {
    fill(clr[0], clr[1], clr[2]);
    noStroke();
    translate(width / 2, height / 2, 0);
    sphere(radius);
    for (int i = 0; i < planets.length; ++i) {
      planets[i].show();
    }
  }
}
