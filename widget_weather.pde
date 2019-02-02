class WeatherScreenWidget extends ScreenWidget {
  public WeatherScreenWidget() {
  }
  
  boolean drawPixel(int x, int y, boolean prevState) {
    int[] coords = getScreenCoords(x, y);
    float radius = (PIXEL_SIZE + GUTTER) * 0.5;
    if (Math.abs(coords[0] - mouseX) <= radius &&
      Math.abs(coords[1] - mouseY) <= radius) {
      return true;
    }
    
    return prevState;
  }
}
