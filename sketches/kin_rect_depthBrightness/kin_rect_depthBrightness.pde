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

// Kinect Library object
Kinect kinect;

float MIN_THRESH = 480;
float MAX_THRESH = 930;
PImage KINECT_img;
PImage LG_img;  // for the full screen image

boolean SHOW_CALIBRATION = true;


// Scale up to LG screen from Kinect resolution
float LG_SCALE_X;
float LG_SCALE_Y;

int SCREEN_NUM = 2;

void setup() {
  fullScreen(SCREEN_NUM); // must be the first line in setup
  //size(640, 480);
  kinect = new Kinect(this);
  kinect.initDepth();
  kinect.enableMirror(true);
  KINECT_img = createImage(kinect.width, kinect.height, RGB);
  LG_img = createImage(width, height, RGB);
  println("press 'c' to toggle calibration view");
  
  LG_SCALE_X = width/kinect.width;
  LG_SCALE_Y = height/kinect.height;
}


void draw() {
  background(0);

//println(LG_SCALE_X);

  if (SHOW_CALIBRATION) {
    showCalibration();
  } else {
    showLGScreen();
  }
}