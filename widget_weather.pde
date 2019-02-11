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
  }
  
  void update() {
    if (lastCheckTime < 0 || millis() - lastCheckTime > WEATHER_CHECK_FREQUENCY) {
      lastCheckTime = millis();
      
      // first clear icons
      icons[0] = "empty";
      icons[1] = "empty";
      icons[2] = "empty";
      icons[3] = "empty";
      icons[4] = "empty";
      temps[0] = 0;
      temps[1] = 0;
      temps[2] = 0;
      temps[3] = 0;
      temps[4] = 0;
      
      try {
        JSONObject json = loadJSONObject("https://api.openweathermap.org/data/2.5/forecast?q=" + WEATHER_LOCATION + "&appid=" + WEATHER_KEY);
        JSONArray list = json.getJSONArray("list");
        String desc;
        int temp, j;
        for(int i = 0; i < WEATHER_COUNT; i++) {
          j = i * 8 + 8 - (5 + floor((hour() - 1) / 3.0)) % 8;
          println(list.getJSONObject(j).getString("dt_txt"));
          desc = list.getJSONObject(j).getJSONArray("weather").getJSONObject(0).getString("icon").substring(0, 2);
          temp = round(list.getJSONObject(j).getJSONObject("main").getFloat("temp") - 273.15);
          println("desc = " + desc + ", t = " + str(temp));
          switch(desc) {
            case "01": icons[i] = "clear"; break;
            case "02": icons[i] = "cloud"; break;
            case "03": icons[i] = "cloud+"; break;
            case "04": icons[i] = "cloud++"; break;
            case "09": icons[i] = "rain"; break;
            case "10": icons[i] = "rain+"; break;
            case "11": icons[i] = "rain++"; break;
            case "13": icons[i] = "snow"; break;
            case "50": icons[i] = "mist"; break;
          }
          temps[i] = temp;
        }
      } catch(Exception e) {
        println("WeatherScreenWidget update error: " + e.getMessage());
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
    
    String temp = str(this.temps[index]);
    int tempWidth = getTextSymbolWidth(temp);
    int shiftX = index * shift;
    int textShiftX = index * shift + 4 - round(tempWidth / 2);
    int value =
      weatherSymbols.getSymbolValue(this.icons[index], x - baseX - 1 - shiftX, y - baseY) +
      getTextSymbolValue(temp, x - baseX - textShiftX, y - baseY - 9);
    
    return value > 0 ? 1.0 : prevState;
  }
}
