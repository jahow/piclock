class ClockScreenWidget extends ScreenWidget {
  int baseX;
  int baseY;
  String char1, char2, char3, char4;
  
  public ClockScreenWidget(int x, int y) {
    baseX = x;
    baseY = y;
  }
  
  void update() {
    int left = hour();
    int right = minute();
    char1 = str(floor(left / 10));
    char2 = str(left % 10);
    char3 = str(floor(right / 10));
    char4 = str(right % 10);
  }
  
  float drawPixel(int x, int y, float prevState) {
    int startX = baseX;
    int startY = baseY;
    int width = clockSymbols.getBaseWidth();
    int value = clockSymbols.getSymbolValue(char1, x - startX, y - startY) +
      clockSymbols.getSymbolValue(char2, x - startX - width - 3, y - startY) +
      clockSymbols.getSymbolValue(second() % 2 == 0 ? "up" : "down", x - startX - 2 * width - 6, y - startY) +
      clockSymbols.getSymbolValue(char3, x - startX - 3 * width - 3, y - startY) +
      clockSymbols.getSymbolValue(char4, x - startX - 4 * width - 6, y - startY);
    
    return value > 0 ? 1.0 : prevState;
  }
}
