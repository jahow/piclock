// This displays a small widget to set the clock time
class AlarmClockScreenWidget extends ScreenWidget {
  int baseX;
  int baseY;
  int dayIndex;    // 0 is monday, 1 is tuesday, ... 6 is sunday
  int hour;
  int minute;
  String hourText;
  String minuteText;
  
  public AlarmClockScreenWidget(int x, int y, int day) {
    baseX = x;
    baseY = y;
    dayIndex = day;
    
    // TODO: read from file
    hour = 23;
    minute = 12;
  }
  
  void update() {
    hourText = nf(hour, 2, 0);
    minuteText = nf(minute, 2, 0);
  }
  
  float drawPixel(int x, int y, float prevState) {
    int width = smallClockSymbols.getBaseWidth();
    int height = smallClockSymbols.getHeight();
    int value =
      buttonSymbols.getSymbolValue("up", x - baseX - 1, y - baseY + 1) +
      smallClockSymbols.getSymbolValue(hourText.substring(0, 1), x - baseX, y - baseY - 4) +
      smallClockSymbols.getSymbolValue(hourText.substring(1, 2), x - baseX - width - 1, y - baseY - 4) +
      smallClockSymbols.getSymbolValue(minuteText.substring(0, 1), x - baseX, y - baseY - height - 5) +
      smallClockSymbols.getSymbolValue(minuteText.substring(1, 2), x - baseX - width - 1, y - baseY - height - 5) +
      buttonSymbols.getSymbolValue("down", x - baseX - 1, y - baseY - height * 2 - 5);
    return value > 0 ? 1.0 : prevState;
  }
  
  public void handleClick(int x, int y) {
    int height = smallClockSymbols.getHeight();
    
    if (x >= baseX && x <= baseX + 5 && y >= baseY - 2 && y <= baseY + 3) {
      minute++;
      if (minute > 59) {
        minute = 0;
        hour++;
      }
      if (hour > 23) {
        hour = 0;
      }
    } else if (x >= baseX && x <= baseX + 5 && y >= baseY + height * 2 + 5 && y <= baseY + height * 2 + 10) {
      minute--;
      if (minute < 0) {
        minute = 59;
        hour--;
      }
      if (hour < 0) {
        hour = 23;
      }
    } 
  }
}
