OPC opc;
Mover mover;

int n =0;

int nPixels = 54;
int spacing = 2;
float nOfStrips = 15;

PVector position;

PImage texture;
Ring rings[];
float smoothX, smoothY;
boolean f = false;

void setup()
{
  size(500, 400, P3D);
  colorMode(HSB, 100);
  texture = loadImage("ring.png");

  opc = new OPC(this, "127.0.0.1", 7890);
  //opc.ledGrid8x8(0, width/2, height/2, height / 16.0, 0, false);

  // Create grid
  //spacing = (height / nPixels);
  for (int i=0; i<15; i++) {
    //opc.ledStrip(index, count, x, y, spacing, angle, reversed)
    opc.ledStrip(i * 64, nPixels, (i * width/nOfStrips) + (width/nOfStrips)/2, height/2, height/nPixels, PI/2, false);
  }


  // We can have up to 100 rings. They all start out invisible.
  rings = new Ring[100];
  for (int i = 0; i < rings.length; i++) {
    rings[i] = new Ring();
  }

  mover = new Mover(20);
  position = new PVector(0, 0);
}

void draw()
{
  background(0);

  mover.update();
  //mover.drawMover();
  position = mover.getPosition();

  //// Smooth out the mouse location. The smoothX and smoothY variables
  //// move toward the mouse without changing abruptly.
  float prevX = smoothX;
  float prevY = smoothY;
  //smoothX += (mouseX - smoothX) * 0.1;
  //smoothY += (mouseY - smoothY) * 0.1;
  smoothX += (position.x - smoothX) * 0.1;
  smoothY += (position.y - smoothY) * 0.1;

  // At every frame, randomly respawn one ring
  rings[int(random(rings.length))].respawn(prevX, prevY, smoothX, smoothY);

  // Give each ring a chance to redraw and update
  for (int i = 0; i < rings.length; i++) {
    rings[i].draw();
  }
}
