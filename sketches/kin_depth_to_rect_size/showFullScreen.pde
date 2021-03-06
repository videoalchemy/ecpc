

void showFullScreen() {
  
   
 // KINECT_img.loadPixels();

  PImage dImg = kinect.getDepthImage();
  //image(dImg, 0, 0);

  // Get the raw depth as array of integers
  int[] depth = kinect.getRawDepth();
  
   // setup for closest-depth world record
  int record = 2500;
  //int record = kinect.height; // to find the highest point
  int rx = 0;
  int ry = 0;
  
  // define rect size and grid size
  int skip = 6;
  
  // walk through every [skip] pixels of depth image and snatch the raw depth
  for (int x = 0; x < dImg.width; x+=skip) {
    for (int y = 0; y < dImg.height; y+=skip) {
      
      // convert the x,y cordinate into 1D index number
      int depthIndex = x + y * dImg.width;
      
      // extract raw depth value from the raw depth array
      int depthValue = depth[depthIndex];
      
      // test raw depth against threshold 
      //   keep pixel if its depth falls between min and max
      //   otherwise, color black
      if (depthValue > MIN_THRESH && depthValue < MAX_THRESH) {   // subtracts a specific area for detection && x > 100 && y > 50) {
        
        // if the raw depth value passes the conditions 
        //    resort to low res depth image pixel at index
        //    extract brightness
        //    set fill
        float b = brightness(dImg.pixels[depthIndex]);
        fill(b*(b/255)*1.9,b); // the extra math here amplifies the brightness in a smaller range
        
        //float newX = x*FS_SCALE_X;
        rect(x*FS_SCALE_X - (b*.2), y*FS_SCALE_Y - (b*.2), skip+skip*FS_SCALE_X + (b*.2), skip+skip*FS_SCALE_Y + (b*.2));
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
  //ellipse(rx*FS_SCALE_X, ry*FS_SCALE_Y, 42, 42);

  
}