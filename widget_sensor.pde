// TODO: read values from a sensor on GPIO

// This displays the date along with temp and humidity values
class SensorScreenWidget extends ScreenWidget {
  int baseX;
  int baseY;
  private int temp;
  private int hr;
  
  public SensorScreenWidget(int x, int y) {
    baseX = x;
    baseY = y;
    
    temp = 45;
    hr = 38;
  }
  
  boolean drawPixel(int x, int y, boolean prevState) {
    int value =
      getTextSymbolValue("t°", x - baseX, y - baseY) +
      getTextSymbolValue("%h", x - baseX - 12, y - baseY) +
      getTextSymbolValue(temp + "", x - baseX, y - baseY - 7) +
      getTextSymbolValue(hr + "", x - baseX - 12, y - baseY - 7);
    return value > 0 ? true : prevState;
  }
}
