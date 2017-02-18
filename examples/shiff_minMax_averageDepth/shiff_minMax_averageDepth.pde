// shiffman's minmaxthreshold example

import org.openkinect.processing.*;

// Kinect Library object
Kinect kinect;

float minThresh = 480;
float maxThresh = 650;
PImage img;

void setup() {
  size(640, 480);
  kinect = new Kinect(this);
  kinect.initDepth();
  //kinect.initDevice();
  img = createImage(kinect.width, kinect.height, RGB);
}


void draw() {
  background(0);

  img.loadPixels();
  
  minThresh = map(mouseX, 0, width, 0, 2048);
  maxThresh = map(mouseY, 0, height, 0, 2048);
  

  // Get the raw depth as array of integers
  int[] depth = kinect.getRawDepth();
  
  float sumX = 0;
  float sumY = 0;
  float totalPixels = 0;
  
  for (int x = 0; x < kinect.width; x++) {
    for (int y = 0; y < kinect.height; y++) {
      int offset = x + y * kinect.width;
      int d = depth[offset];

      
      if (d > minThresh && d < maxThresh && x > 100) {
        img.pixels[offset] = color(255, 0, 150);
         
        sumX += x;
        sumY += y;
        totalPixels++;
        
      } else {
        img.pixels[offset] = color(0);
      }  
    }
  }

  img.updatePixels();
  image(img, 0, 0);
  
  float avgX = sumX / totalPixels;
  float avgY = sumY / totalPixels;
  fill(150,0,255);
  ellipse(avgX, avgY, 64, 64);
  
  // calibration
  fill(255);
  textSize(32);
  text(minThresh + " " + maxThresh, 10, 64);
}