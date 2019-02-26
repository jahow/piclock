class ScreenWidget {
  int translateX = 0;
  int translateY = 0;
  float opacity = 1.0;
  
  public ScreenWidget() {
  }
  
  void update() {
  }
  
  float drawPixel(int x, int y, float prevState) {
    return prevState;
  }
  
  public float drawTransformedPixel(int x, int y, float prevState) {
    return Math.max(prevState, drawPixel(x - translateX, y - translateY, prevState) * opacity);
  }
  
  public void translate(int x, int y) {
    this.translateX = x;
    this.translateY = y;
  }
  
  public void setOpacity(float value) {
    this.opacity = value;
  }
  
  public void handleClick(int x, int y, boolean first) {
  }
}
