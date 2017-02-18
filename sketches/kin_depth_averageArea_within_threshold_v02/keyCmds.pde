
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