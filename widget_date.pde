import java.util.Calendar;
import java.util.TimeZone;

Calendar cal = Calendar.getInstance(TimeZone.getDefault());

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
    switch(cal.get(Calendar.DAY_OF_WEEK)) {
      case Calendar.SUNDAY: dayName = "dim."; break;
      case Calendar.MONDAY: dayName = "lun."; break;
      case Calendar.TUESDAY: dayName = "mar."; break;
      case Calendar.WEDNESDAY: dayName = "mer."; break;
      case Calendar.THURSDAY: dayName = "jeu."; break;
      case Calendar.FRIDAY: dayName = "ven."; break;
      case Calendar.SATURDAY: dayName = "sam."; break;
    }
    date = pad(str(day()), 2) + "-" + pad(str(month()), 2);
  }
  
  float drawPixel(int x, int y, float prevState) {
    int value = getTextSymbolValue(dayName, x - baseX, y - baseY) +
      getTextSymbolValue(date, x - baseX, y - baseY - 7);
    return value > 0 ? 1.0 : prevState;
  }
}
