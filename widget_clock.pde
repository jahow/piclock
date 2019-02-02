class ClockScreenWidget extends ScreenWidget {
  int baseX;
  int baseY;
  
  public ClockScreenWidget(int x, int y) {
    baseX = x;
    baseY = y;
  }
  
  boolean drawPixel(int x, int y, boolean prevState) {
    int startX = baseX;
    int startY = baseY;
    int left = hour();
    int right = minute();
    int width = clockSymbols.getBaseWidth();
    int value = clockSymbols.getSymbolValue(str(floor(left / 10)), x - startX, y - startY) +
      clockSymbols.getSymbolValue(str(left % 10), x - startX - width - 3, y - startY) +
      clockSymbols.getSymbolValue(second() % 2 == 0 ? "up" : "down", x - startX - 2 * width - 6, y - startY) +
      clockSymbols.getSymbolValue(str(floor(right / 10)), x - startX - 3 * width - 3, y - startY) +
      clockSymbols.getSymbolValue(str(right % 10), x - startX - 4 * width - 6, y - startY);
    
    return value > 0 ? true : prevState;
  }
}
