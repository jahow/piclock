import java.text.SimpleDateFormat;

final int WEATHER_COUNT = 5;
final int WEATHER_CHECK_FREQUENCY = 60 * 1000 * 15;
final String WEATHER_LOCATION = "sonnaz";
final String WEATHER_KEY = "a48634ed18dac4fc58477ba9a2e9442c";
final int TEMP_NOT_FOUND = -1000;

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
      temps[0] = TEMP_NOT_FOUND;
      temps[1] = TEMP_NOT_FOUND;
      temps[2] = TEMP_NOT_FOUND;
      temps[3] = TEMP_NOT_FOUND;
      temps[4] = TEMP_NOT_FOUND;
      
      try {
        JSONObject json = loadJSONObject("https://api.openweathermap.org/data/2.5/forecast?q=" + WEATHER_LOCATION + "&appid=" + WEATHER_KEY);
        JSONArray list = json.getJSONArray("list");
        String desc;
        int temp;
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.HOUR_OF_DAY, 12);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        String f;
        int found;
        for(int i = 0; i < WEATHER_COUNT; i++) {
          f = format.format(cal.getTime());
          found = -1;
          for (int j = 0; j < list.size(); j++) {
            if (f.equals(list.getJSONObject(j).getString("dt_txt"))) {
              found = j;
              break;
            }
          }
          
          if (found >= 0) {
            JSONObject obj = list.getJSONObject(found);
            //println(obj.getString("dt_txt"));
            desc = obj.getJSONArray("weather").getJSONObject(0).getString("icon").substring(0, 2);
            temp = round(obj.getJSONObject("main").getFloat("temp") - 273.15);
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
          cal.add(Calendar.DAY_OF_MONTH, 1);
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
    
    int tempValue = 0;
    int shiftX = index * shift;
    
    if (this.temps[index] != TEMP_NOT_FOUND) {
      String temp = str(this.temps[index]);
      int tempWidth = getTextSymbolWidth(temp);
      int textShiftX = index * shift + 4 - round(tempWidth / 2);
      tempValue = getTextSymbolValue(temp, x - baseX - textShiftX, y - baseY - 9);
    }
    
    int value = tempValue +
      weatherSymbols.getSymbolValue(this.icons[index], x - baseX - 1 - shiftX, y - baseY);
    
    return value > 0 ? 1.0 : prevState;
  }
}
