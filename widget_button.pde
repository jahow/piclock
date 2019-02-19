// execute can return a string; this will be used as the new symbol
class Callable {
  public String execute() { return null; };
}

class ButtonScreenWidget extends ScreenWidget {
  int baseX;
  int baseY;
  private String temp;
  private String hr;
  int lastCheckTime = -1;
  Callable callback;
  String symbol;
  int[] hitBounds;
  
  public ButtonScreenWidget(int x, int y, Callable callback, String symbol) {
    this(x, y, callback, symbol, false);
  }
  
  public ButtonScreenWidget(int x, int y, Callable callback, String symbol, boolean allScreen) {
    baseX = x;
    baseY = y;
    this.callback = callback;
    this.symbol = symbol;
    this.hitBounds = allScreen ?
      new int[] {0, 0, getPixelCountX(), getPixelCountY()} :
      new int[] {baseX, baseY, baseX + buttonSymbols.getBaseWidth(), baseY + buttonSymbols.getHeight()}; 
  }
  
  void update() {
  }
  
  float drawPixel(int x, int y, float prevState) {
    int value = buttonSymbols.getSymbolValue(symbol, x - baseX, y - baseY);
    return value > 0 ? 1.0 : prevState;
  }
  
  public void handleClick(int x, int y) {
    if (x < hitBounds[0] || x > hitBounds[2] || y < hitBounds[1] || y > hitBounds[3]) {
      return;
    }
    
    String newSymbol = callback.execute();
    if (newSymbol != null) {
      symbol = newSymbol;
    }
  }
}
