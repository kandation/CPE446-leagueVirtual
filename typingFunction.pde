void keyReleased_isGetUserName() {
  if (!isGetUserName) {
    if (key == BACKSPACE && keyd.length() > 0) {
      keyd = keyd.substring( 0, keyd.length()-1 );
    } else {
      if (keyd.length() < 15) {
        keyd += str(key);
      }
    }
  }
}