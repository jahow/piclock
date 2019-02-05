final int WEATHER_COUNT = 5;

// TODO: do a request like this:
// https://api.openweathermap.org/data/2.5/forecast?q=sonnaz&appid=a48634ed18dac4fc58477ba9a2e9442c

class WeatherScreenWidget extends ScreenWidget {
  int baseX;
  int baseY;
  private String[] icons = new String[WEATHER_COUNT];
  private int[] temps = new int[WEATHER_COUNT];
  
  
  public WeatherScreenWidget(int x, int y) {
    baseX = x;
    baseY = y;
    
    // todo: update this using the OWP api
    icons[0] = "clear";
    icons[1] = "rain++";
    icons[2] = "mist";
    icons[3] = "cloud";
    icons[4] = "clear";
    temps[0] = 29;
    temps[1] = 24;
    temps[2] = 1;
    temps[3] = 8;
    temps[4] = 11;
  }
  
  boolean drawPixel(int x, int y, boolean prevState) {
    int shift = 11;
    
    if (y < baseY || x < baseX) {
      return prevState;
    }
    
    int index = floor((x - baseX) / shift);
    if (index >= WEATHER_COUNT) {
      return prevState;
    }
    
    String tempChar1 = str(floor(this.temps[index] / 10));
    String tempChar2 = str(floor(this.temps[index] % 10));
    int char1Width = textSymbols.getSymbolWidth(tempChar1);
    int char2Width = textSymbols.getSymbolWidth(tempChar2);
    int tempWidth = char1Width + char2Width + 1;
    int shiftX = index * shift;
    int textShiftX = index * shift + 4 - floor(tempWidth / 2);
    int value =
      weatherSymbols.getSymbolValue(this.icons[index], x - baseX - 1 - shiftX, y - baseY) +
      textSymbols.getSymbolValue(tempChar1, x - baseX - textShiftX, y - baseY - 9) +
      textSymbols.getSymbolValue(tempChar2, x - baseX - textShiftX - 1 - char1Width, y - baseY - 9);
    
    return value > 0 ? true : prevState;
  }
}
