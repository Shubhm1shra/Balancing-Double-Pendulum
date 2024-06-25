class Slider {
  float x, y;
  color sliderColor, slideColor;
  Slider(float x, float y) {
    this.x = x;
    this.y = y;
  }
  Slider(float x, float y, color slideColor, color sliderColor) {
    this.x = x;
    this.y = y;
    this.slideColor = slideColor;
    this.sliderColor = sliderColor;
  }
}
