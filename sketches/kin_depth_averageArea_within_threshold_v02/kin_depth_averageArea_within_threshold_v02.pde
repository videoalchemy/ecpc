/* jstephens 2017_02
    ecpc installation
    experiment sketch
NOTES:
  * Kinect 1414 
    - raw depth values 0-2048
    - depthImage: 640x480
TODO:
  [ ] remove P3D and revert to assigning pixel color
  [ ] use void depthEvent(Kinect k) {}
      // ask for depthImage only when it's available
  [ ] divide threshold depth into front-half and back-half
      // bc soon a spandex screen will register impressions v depressions
  [ ] use two colors to distinguish pixels as front-half or back-half
  [ ] use img.loadPixels and img.updatePixels
  [ ] add mouse controls for simple calibration
  
*/
    
//import org.openkinect.tests.*;
//import org.openkinect.freenect.*;
import org.openkinect.processing.*;

Kinect kinect;

float MIN_THRESH = 364;
float MAX_THRESH = 904;
PImage CALIBRATION_img;
PImage FULL_img;  // fullscreen image
PImage dImg;

boolean SHOW_CALIBRATION = true;

// ratio between fullscreen and Kinect dimensions 
// use to upscale Kinect image to fullscreen
float FS_SCALE_X;
float FS_SCALE_Y;

int SCREEN_NUM = 2;

//////////////////////////////////////////////////////////
void setup() {
  fullScreen(P2D, SCREEN_NUM);
  //size(1024, 768, P2D);
  //fullScreen(P3D, SCREEN_NUM);
  //size(1024, 768, P3D);
  //fullScreen(SCREEN_NUM);
  //size(640, 480);
  noStroke();
  kinect = new Kinect(this);
  kinect.initDepth();
  kinect.enableMirror(true);
  
  CALIBRATION_img = createImage(kinect.width, kinect.height, RGB);
  FULL_img = createImage(kinect.width, kinect.height, RGB);
  //FULL_img     = createImage(width, height, RGB);
  
  // factor by which to upscale Kinect dimensions 
  FS_SCALE_X = width/kinect.width;
  FS_SCALE_Y = height/kinect.height;
  //FS_SCALE_X = 1024.0/kinect.width;
  //FS_SCALE_Y = 768.0/kinect.height;
  
  println("press 'c' to toggle calibration view");
  
  //DEBUG
  println("FS_SCALE_X = " + FS_SCALE_X);
  println(FS_SCALE_Y);
  println("kinect.width = " + kinect.width);
  println("kinect.height = " + kinect.height);
}


//////////////////////////////////////////////////////////
void draw() {
  background(100);

  if (SHOW_CALIBRATION) {
    showCalibration();
  } else {
    showFullScreen();
  }
}