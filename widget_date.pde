// This displays the date
class DateScreenWidget extends ScreenWidget {
  int baseX;
  int baseY;
  private String dayName;
  private String date;
  
  public DateScreenWidget(int x, int y) {
    baseX = x;
    baseY = y;
    
    dayName = "jeu.";
    date = "12-02";
  }
  
  float drawPixel(int x, int y, float prevState) {
    int value = getTextSymbolValue(dayName, x - baseX, y - baseY) +
      getTextSymbolValue(date, x - baseX, y - baseY - 7);
    return value > 0 ? 1.0 : prevState;
  }
}
