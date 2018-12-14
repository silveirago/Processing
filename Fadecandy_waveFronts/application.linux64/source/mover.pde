class Mover {

  float t, t2 = 0.01;
  float size;

  PVector position;
  PVector velocity;
  PVector perlinNoise;
  PVector pPosition;
  PVector pVelocity;
  

  Mover(float _size) {
    size = _size;
    position = new PVector(random(width), random(height));
    velocity = new PVector(0.3, 0.3);
    perlinNoise = new PVector(noise(t+(random(1000))), noise(t+(random(1000))));
    //pPosition = new PVector(width/2, height/2);
  }

  void update() {
    position.set(map(noise(t), 0, 1, 0, width), map(noise(t+100), 0, 1, 0, height));
    t += 0.05;
    t2 += 0.05;
  }
  
  void drawMover() {
    fill(200, 100);
    ellipse(position.x, position.y, size, size);
  }
  
  PVector getPosition() {
   return position; 
  }
}
