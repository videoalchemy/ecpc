/* dev_snowflake
    turns users into snowflakes using depth info
    tracks closest point with snowflake
    [ ] full screen
    [ ] adjust threshold for dev area
    [ ] add easing
    [ ] turn on mirror
    [ ] add controller for min max threshold
*/
    
import org.openkinect.tests.*;
import org.openkinect.freenect.*;
import org.openkinect.processing.*; //<>//

Kinect kinect;

float MIN_THRESH = 480;
float MAX_THRESH = 930;
PImage KINECT_img;
PImage FS_img;  // fullscreen image

boolean SHOW_CALIBRATION = true;

// ratio between fullscreen and Kinect dimensions 
// use to upscale Kinect image to fullscreen
float FS_SCALE_X;
float FS_SCALE_Y;

int SCREEN_NUM = 2;

//////////////////////////////////////////////////////////
void setup() {
  size(1024, 768, P3D);
  //fullScreen(SCREEN_NUM);
  //size(640, 480);
  //noStroke();
  kinect = new Kinect(this);
  kinect.initDepth();
  kinect.enableMirror(true);
  
  KINECT_img = createImage(kinect.width, kinect.height, RGB);
  FS_img     = createImage(width, height, RGB);
  
  // factor by which to upscale Kinect dimensions 
  FS_SCALE_X = width/kinect.width;
  FS_SCALE_Y = height/kinect.height;
  
  println("press 'c' to toggle calibration view");
}


//////////////////////////////////////////////////////////
void draw() {
  background(0);

  //println(FS_SCALE_X);

  if (SHOW_CALIBRATION) {
    showCalibration();
  } else {
    showFullScreen();
  }
}