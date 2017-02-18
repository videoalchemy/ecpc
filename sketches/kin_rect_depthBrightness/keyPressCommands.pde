
void keyPressed() {
  if (key == 'c') {
    SHOW_CALIBRATION = !SHOW_CALIBRATION; 
  } else if (key == CODED) {
    if (keyCode == UP) {
      MAX_THRESH++;
    } else if (keyCode == DOWN) {
      MAX_THRESH--;
    }
  }
}


void showCalibration() {
  text("Press 'c' to disable calibration view", 10, height*.979);
  text("Arrow Up/Down to adjust threshold", 10, height*.99);
  text("Current MAX_THRESHOLD = " + MAX_THRESH, 230, height*.99);
  
  
  KINECT_img.loadPixels();

  PImage dImg = kinect.getDepthImage();
  //image(dImg, 0, 0);

  // Get the raw depth as array of integers
  int[] depth = kinect.getRawDepth();
  
  int record = 2500;
  //int record = kinect.height;
  int rx = 0;
  int ry = 0;

  for (int x = 0; x < kinect.width; x++) {
    for (int y = 0; y < kinect.height; y++) {
      int offset = x + y * kinect.width;
      int d = depth[offset];
      
      // determine if it falls into threshold                     
      if (d > MIN_THRESH && d < MAX_THRESH) {   // subtracts a specific area for detection && x > 100 && y > 50) {
        KINECT_img.pixels[offset] = color(255, 0, 150);
        
        // assign cordinates for closest point tracking
        if (d < record) {
          record = d;
          rx = x;
          ry = y;
        }
         
      } else {
        KINECT_img.pixels[offset] = color(0);
        //KINECT_img.pixels[offset] = dImg.pixels[offset];
      }
    }
  }
  KINECT_img.updatePixels();
  image(KINECT_img,0,0);
  
  fill(255);
  ellipse(rx, ry, 32, 32);

}