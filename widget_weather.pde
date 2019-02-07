final int WEATHER_COUNT = 5;
final int WEATHER_CHECK_FREQUENCY = 60 * 1000 * 15;
final String WEATHER_LOCATION = "sonnaz";
final String WEATHER_KEY = "a48634ed18dac4fc58477ba9a2e9442c";

// TODO: do a request like this:
// https://api.openweathermap.org/data/2.5/forecast?q=sonnaz&appid=a48634ed18dac4fc58477ba9a2e9442c

class WeatherScreenWidget extends ScreenWidget {
  int baseX;
  int baseY;
  private String[] icons = new String[WEATHER_COUNT];
  private int[] temps = new int[WEATHER_COUNT];
  int lastCheckTime = -1;
  
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
  
  void update() {
    if (lastCheckTime < 0 || millis() - lastCheckTime > WEATHER_CHECK_FREQUENCY) {
      lastCheckTime = millis();
      
      JSONObject json = loadJSONObject("https://api.openweathermap.org/data/2.5/forecast?q=" + WEATHER_LOCATION + "&appid=" + WEATHER_KEY);
      JSONArray list = json.getJSONArray("list");
      int[] indices = {4, 12, 20, 28, 36};
      int j = 0;
      String desc;
      int temp;
      for(int i : indices) {
        //println(list.getJSONObject(i).getString("dt_txt"));
        desc = list.getJSONObject(i).getJSONArray("weather").getJSONObject(0).getString("icon").substring(0, 2);
        temp = round(list.getJSONObject(i).getJSONObject("main").getFloat("temp") - 273.15);
        println("desc = " + desc + ", t = " + str(temp));
        switch(desc) {
          case "01": icons[j] = "clear"; break;
          case "02": icons[j] = "cloud"; break;
          case "03": icons[j] = "cloud+"; break;
          case "04": icons[j] = "cloud++"; break;
          case "09": icons[j] = "rain"; break;
          case "10": icons[j] = "rain+"; break;
          case "11": icons[j] = "rain++"; break;
          case "13": icons[j] = "snow"; break;
          case "50": icons[j] = "mist"; break;
          default: icons[j] = "clear"; break;
        }
        temps[j] = temp;
        j++;
      }
    }
  }
  
  float drawPixel(int x, int y, float prevState) {
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
    
    return value > 0 ? 1.0 : prevState;
  }
}
