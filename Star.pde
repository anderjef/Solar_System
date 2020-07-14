class Star {
  float radius; //size of star
  float[] clr = {random(255), random(255), random(255)}; //black suns are allowed
  Planet[] planets;
  
  Star(float r) {
    radius = r;
  }
  
  void update() {
    
  }
  
  void show() {
    fill(clr[0], clr[1], clr[2]);
    translate(width / 2, height / 2);
    sphere(radius);
    if (clr[0] + clr[1] + clr[2] == 0) {
      lights(); //ambient light is added if the sun is black (which would otherwise mean there is no light which would make observing the solar system quite boring)
    }
    pointLight(clr[0], clr[1], clr[2], 0, 0, 0);
  }
}
