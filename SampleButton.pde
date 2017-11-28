class SampleButton {
  boolean isActive;
  boolean onToggle;
  float w;
  float h;
  float px;
  float py;
  String lable;
  color c= color(0);
  color tc = color(255-red(c), 255-green(c), 255-blue(c));

  SampleButton(String lable, float px, float py, float w, float h) {
    isActive = false;
    this.w = w;
    this.h = h;
    this.lable = lable;
    this.px = px;
    this.py = py;
  }

  void show() {
    color tempColor = c;
    
    if (isArea()) {
      if (isOnClick() && !onToggle) {
        onToggle = true;
        isActive = true;
        setColor(color(25, 2, 255));
      } else {
        setColor(color(255));
      }
    } 
    pushMatrix();
    fill(c);
    if (onMousReleased) {
      onToggle = false;
    }
    rectMode(CENTER);
    rect(px, py, w, h);
    fill(tc);
    float k = (((w+h)/2) <= 70)?0.2:0.1;
    textSize(((w+h)/2)*k);
    textAlign(CENTER, CENTER);
    textMode(CENTER);
    text(lable, px, py);
    popMatrix();
    setColor(tempColor);
  }

  boolean isArea() {
    //(mouseY >= py && mouseY < py+h))
    return ((mouseX >= px-(w/2) && mouseX < (px+w)-(w/2)) && (mouseY >= py-(h/2) && mouseY < (py+h)-(h/2)) );
  }

  boolean isOnClick() {
    return mousePressed;
  }

  void setColor(color c) {     
    this.c = c;
    tc = color(255-red(c), 255-green(c), 255-blue(c));
  }
  
  boolean getActive(){
    return this.isActive;
  }
  
  void completed(){
    this.isActive = false;
  }
}