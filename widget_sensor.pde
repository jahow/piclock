final int SENSOR_CHECK_FREQUENCY = 5 * 1000;

// This displays the date along with temp and humidity values
class SensorScreenWidget extends ScreenWidget {
  int baseX;
  int baseY;
  private String temp;
  private String hr;
  int lastCheckTime = -1;
  
  public SensorScreenWidget(int x, int y) {
    baseX = x;
    baseY = y;
  }
  
  void update() {
    if (lastCheckTime < 0 || millis() - lastCheckTime > SENSOR_CHECK_FREQUENCY) {
      lastCheckTime = millis();
      try {
        String[] lines = loadStrings("sensor_data");
        if (lines == null) { throw new Exception(); }
        
        String[] data = lines[0].split(" ");
        temp = str(int(data[0]));
        hr = str(int(data[1]));
      } catch(Exception e) {
        temp = "-";
        hr = "-";
      }
    }
  }
  
  float drawPixel(int x, int y, float prevState) {
    int value =
      getTextSymbolValue("t°", x - baseX, y - baseY) +
      getTextSymbolValue("%h", x - baseX - 12, y - baseY) +
      getTextSymbolValue(temp, x - baseX, y - baseY - 7) +
      getTextSymbolValue(hr, x - baseX - 12, y - baseY - 7);
    return value > 0 ? 1.0 : prevState;
  }
}
