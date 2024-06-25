class Slider {
  float slideX, slideY, slideWidth, slideHeight;
  float sliderX, sliderY;
  float sliderWidth = 50;
  float sliderHeight = 6;
  float xOff;
  boolean over = false;
  boolean lock = false;
  boolean translation = false;
  float transX, transY;

  Slider(float slideX, float slideY, float slideWidth, float slideHeight) {
    this.slideWidth = slideWidth;
    this.slideHeight = slideHeight;
    this.slideX = slideX - slideWidth/2;
    this.slideY = slideY;
    
    this.sliderX = this.slideX + slideWidth/2;
    this.sliderY = this.slideY;
  }

  void display() {
    stroke(255);
    line(this.slideX, this.slideY, this.slideX + this.slideWidth, this.slideY);
    
    float mPosX, mPosY;
    
    if(translation) {
      mPosX = mouseX - this.transX;
      mPosY = mouseY - this.transY;
    } else {
      mPosX = mouseX;
      mPosY = mouseY;
    }  

    if(mPosX >= this.sliderX - this.sliderWidth/2 && mPosX <= this.sliderX + this.sliderWidth/2 && mPosY >= this.sliderY - this.sliderHeight/2 && mPosY <= this.sliderY + this.sliderHeight/2) {
      fill(200);
      over = true;
    } else {
      fill(255);
      over = false;
    }

    if(this.sliderX < this.slideX + this.sliderWidth/2) {this.sliderX = this.slideX + this.sliderWidth/2;}
    if(this.sliderX > this.slideX + this.slideWidth - this.sliderWidth/2) {this.sliderX = this.slideX + this.slideWidth - this.sliderWidth/2;}

    rect(this.sliderX - this.sliderWidth/2, this.sliderY - this.sliderHeight/2, this.sliderWidth, this.sliderHeight);
  }
  
  void setTranslation(float x, float y) {
    translation = true;
    this.transX = x;
    this.transY = y;
  }
  
  void ifMousePressed() {
    if(over) {
      lock = true;
      xOff = mouseX - this.sliderX;
    }
  }
  
  void ifMouseDragged() {
    if(lock) {
      this.sliderX = mouseX - xOff;
      if(this.sliderX < this.slideX + this.sliderWidth/2) {this.sliderX = this.slideX + this.sliderWidth/2;}
      if(this.sliderX > this.slideX + this.slideWidth - this.sliderWidth/2) {this.sliderX = this.slideX + this.slideWidth - this.sliderWidth/2;}
    }
  }
  void ifMouseReleased() {
    lock = false;
  }
}
