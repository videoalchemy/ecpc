/* jstephens 2017_02
 ecpc installation
 experiment sketch
 NOTES:
 * Kinect 1414 
 - raw depth values 0-2048
 - depthImage: 640x480
 TODO:
 [ ] use void depthEvent(Kinect k) {}
      --> ask for depthImage only when it's available
 [ ] divide threshold depth into front-half and back-half
      --> bc soon a spandex screen will register impressions v depressions
 [ ] use two colors to distinguish pixels as front-half or back-half
 [ ] use img.loadPixels and img.updatePixels
 [x] add mouse controls for simple calibration
 [x] get(screenWidth) to inform upscale factor 
 */

import org.openkinect.processing.*;

Kinect kinect;

int currentScreen;

float MIN_THRESH = 643;
float MAX_THRESH = 1470;
PImage CALIBRATION_img;
PImage FULL_img;  // fullscreen image
PImage dImg;

boolean calibrate_with_mouse = true;
 
// use to upscale Kinect image to fullscreen
float FS_SCALE_X;
float FS_SCALE_Y;

int SCREEN_NUM = 2;

//////////////////////////////////////////////////////////
void setup() {
  fullScreen(P3D, SCREEN_NUM);
  //size(1024, 768, P3D);
  noStroke();
  kinect = new Kinect(this);
  kinect.initDepth();
  kinect.enableMirror(true);

  CALIBRATION_img = createImage(kinect.width, kinect.height, RGB);
  FULL_img = createImage(kinect.width, kinect.height, RGB);

  // factor by which to upscale Kinect dimensions 
  FS_SCALE_X = width/kinect.width;     // 1024.0/kinect.width;
  FS_SCALE_Y = height/kinect.height;   // 768.0/kinect.height;
  
  showInstructions();
}


//////////////////////////////////////////////////////////
void draw() {
  background(100);

  switch(currentScreen) {   
    case 1: 
      showFullScreen();
      break;
    case 2:
      showZRects();
      break;
    default:
      showCalibration();
  }
}