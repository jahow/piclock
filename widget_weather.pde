// TODO: do a request like this:
// https://api.openweathermap.org/data/2.5/forecast?q=sonnaz&appid=a48634ed18dac4fc58477ba9a2e9442c

class WeatherScreenWidget extends ScreenWidget {
  int baseX;
  int baseY;
  private String icon;
  
  public WeatherScreenWidget(String icon, int x, int y) {
    baseX = x;
    baseY = y;
    this.icon = icon;
  }
  
  boolean drawPixel(int x, int y, boolean prevState) {
    int value = weatherSymbols.getSymbolValue(this.icon, x - baseX, y - baseY);
    
    return value > 0 ? true : prevState;
  }
}
