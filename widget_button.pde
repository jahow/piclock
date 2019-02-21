// execute can return a string; this will be used as the new symbol
class Callable {
  public String execute() { return null; };
}

class ButtonScreenWidget extends ScreenWidget {
  int baseX;
  int baseY;
  private String label;
  int lastCheckTime = -1;
  Callable callback;
  String symbol;
  int[] hitBounds;
  
  public ButtonScreenWidget(int x, int y, Callable callback, String symbol, String label) {
    this(x, y, callback, symbol, false, label);
  }
  
  public ButtonScreenWidget(int x, int y, Callable callback, String symbol) {
    this(x, y, callback, symbol, false, null);
  }
  
  public ButtonScreenWidget(int x, int y, Callable callback, String symbol, boolean allScreen, String label) {
    baseX = x;
    baseY = y;
    this.callback = callback;
    this.symbol = symbol;
    this.hitBounds = allScreen ?
      new int[] {0, 0, getPixelCountX(), getPixelCountY()} :
      new int[] {baseX, baseY, baseX + buttonSymbols.getBaseWidth(), baseY + buttonSymbols.getHeight()}; 
    this.label = label;
  }
  
  void update() {
  }
  
  float drawPixel(int x, int y, float prevState) {
    int width = buttonSymbols.getSymbolWidth(symbol);
    int value = buttonSymbols.getSymbolValue(symbol, x - baseX, y - baseY) +
      (this.label != null ? getTextSymbolValue(this.label, x - baseX - width - 1, y - baseY + 1) : 0);
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
