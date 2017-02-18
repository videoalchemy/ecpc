

void showLGScreen() {
  
   
 // KINECT_img.loadPixels();

  PImage dImg = kinect.getDepthImage();
  //image(dImg, 0, 0);

  // Get the raw depth as array of integers
  int[] depth = kinect.getRawDepth();
   
  int record = 2500;
  //int record = kinect.height;
  int rx = 0;
  int ry = 0;
  
  int skip = 7;
  for (int x = 0; x < dImg.width; x+=skip) {
    for (int y = 0; y < dImg.height; y+=skip) {
      int depthIndex = x + y * dImg.width;
      
      int depthValue = depth[depthIndex];
      
      // determine if it falls into threshold                     
      if (depthValue > MIN_THRESH && depthValue < MAX_THRESH) {   // subtracts a specific area for detection && x > 100 && y > 50) {
        
        // if the depth value passes the conditions then use it to affect output
        
        float b = brightness(dImg.pixels[depthIndex]);
        
        fill(b*(b/255)*1.9);
        //float newX = x*LG_SCALE_X;
        rect(x*LG_SCALE_X,y*LG_SCALE_Y,skip+skip*LG_SCALE_X, skip+skip*LG_SCALE_Y);
        //rect(x,y,skip, skip);
        
        
        //KINECT_img.pixels[depthIndex] = color(0, 255, 150);
        
        // assign cordinates for closest point tracking
        if (depthValue < record) {
          record = depthValue;
          rx = x;
          ry = y;
        }
         
      } else {
        KINECT_img.pixels[depthIndex] = color(0);
        //KINECT_img.pixels[depthIndex] = dImg.pixels[depthIndex];
      }
    }
  }
  KINECT_img.updatePixels();
  //image(KINECT_img,0,0,width,height);
  
  fill(0,255,0);
  //ellipse(rx*LG_SCALE_X, ry*LG_SCALE_Y, 42, 42);

  
}