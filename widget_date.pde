import java.util.Calendar;

// This displays the date
class DateScreenWidget extends ScreenWidget {
  int baseX;
  int baseY;
  private String dayName;
  private String date;
  
  public DateScreenWidget(int x, int y) {
    baseX = x;
    baseY = y;
  }
  
  void update() {
    switch(Calendar.getInstance().get(Calendar.DAY_OF_WEEK)) {
      case 0: dayName = "dim."; break;
      case 1: dayName = "lun."; break;
      case 2: dayName = "mar."; break;
      case 3: dayName = "mer."; break;
      case 4: dayName = "jeu."; break;
      case 5: dayName = "ven."; break;
      case 6: dayName = "sam."; break;
    }
    date = pad(str(day()), 2) + "-" + pad(str(month()), 2);
  }
  
  float drawPixel(int x, int y, float prevState) {
    int value = getTextSymbolValue(dayName, x - baseX, y - baseY) +
      getTextSymbolValue(date, x - baseX, y - baseY - 7);
    return value > 0 ? 1.0 : prevState;
  }
}
