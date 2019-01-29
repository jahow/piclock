class ClockScreenWidget extends ScreenWidget {
  public ClockScreenWidget() {
  }
  
  boolean drawPixel(int x, int y, boolean prevState) {
    int startX = 4;
    int startY = 4;
    int left = hour();
    int right = minute();
    int width = clockSymbols.getBaseWidth();
    int value = clockSymbols.getSymbolValue(str(floor(left / 10)), x - startX, y - startY) +
      clockSymbols.getSymbolValue(str(left % 10), x - startX - width - 1, y - startY) +
      clockSymbols.getSymbolValue(second() % 2 == 0 ? "up" : "down", x - startX - 2 * width - 1, y - startY) +
      clockSymbols.getSymbolValue(str(floor(right / 10)), x - startX - 3 * width- 1, y - startY) +
      clockSymbols.getSymbolValue(str(right % 10), x - startX - 4 * width - 2, y - startY);
    
    return value > 0 ? true : prevState;
  }
}
