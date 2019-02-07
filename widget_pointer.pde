class PointerScreenWidget extends ScreenWidget {
  public PointerScreenWidget() {
  }
  
  float drawPixel(int x, int y, float prevState) {
    int[] coords = getScreenCoords(x, y);
    float radius = (PIXEL_SIZE + GUTTER) * 0.5;
    if (Math.abs(coords[0] - mouseX) <= radius &&
      Math.abs(coords[1] - mouseY) <= radius) {
      return 1.0;
    }
    
    //if (x == getPixelCountX() / 2 || y == getPixelCountY() / 2) {
    //  return true;
    //}
    
    return prevState;
  }
}
