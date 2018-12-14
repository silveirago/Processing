OPC opc;
int nPixels = 54;
int spacing = 2;
float nOfStrips = 15;

import org.openkinect.processing.*;

Kinect kinect;

float minThresh = 100;
float maxThresh = 900;
PImage img;

int averageSize = 8;
int smoothValIndex = 0;
int smoothCount = 0;
int[] smoothVals = new int[averageSize];



void setup()
{
  size(450, 424);

  kinect = new Kinect(this);
  kinect.initDepth();
  //kinect.initDevice();
  img = createImage(kinect.width, kinect.height, RGB);

  // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);

  //spacing = (height / nPixels);
  for (int i=0; i<15; i++) {
    //opc.ledStrip(index, count, x, y, spacing, angle, reversed)
    opc.ledStrip(i * 64, nPixels, (i * width/nOfStrips) + (width/nOfStrips)/2, height/2, height/nPixels, PI/2, false);
  }
}

void draw()
{
  background(0);
  
  img.loadPixels();

  //get the raw depth as array of integers
  int[] depth = kinect.getRawDepth();

  int skip = 3;
  for (int x=0; x < img.width; x++) {
    for (int y=0; y < img.height; y++) {
      int offset = x +y * kinect.width;
      int d = depth[offset];
      //d = smoothVal(d);
      //float b = brightness(img.pixels[offset]);
      img.pixels[offset] = color(255, 0, 150);
      //println(b);
      if (d > minThresh && d < maxThresh) {
        img.pixels[offset] = color(255-map(d, minThresh, maxThresh, 0, 255), 0, map(d, minThresh, maxThresh, 0, 255)); 
      } else {
        img.pixels[offset] = color(random(255),0, random(255));
        img.pixels[offset] = color(0);
      }
    }
  }

  img.updatePixels();
  image(img, 0, 0);
}


int smoothVal(int _input) {  
  int sum = 0;
  smoothCount++;  
  smoothVals[smoothCount%averageSize] = _input;  

  for (int i=0; i<averageSize; i++) {
    sum += smoothVals[i];
  }
  int average = sum / averageSize;
  return average;
}
