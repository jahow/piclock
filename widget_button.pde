// execute can return a string; this will be used as the new symbol
class Callable {
  public String execute() { return null; };
}

class ButtonScreenWidget extends ScreenWidget {
  int baseX;
  int baseY;
  String label;
  int lastCheckTime = -1;
  Callable callback;
  String symbol;
  
  public ButtonScreenWidget(int x, int y, Callable callback, String symbol) {
    this(x, y, callback, symbol, null);
  }
  
  public ButtonScreenWidget(int x, int y, Callable callback, String symbol, String label) {
    baseX = x;
    baseY = y;
    this.callback = callback;
    this.symbol = symbol;
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
  
  public void handleClick(int x, int y, boolean first) {
    int textWidth = label != null ? getTextSymbolWidth(label) : 0;
    if (!first ||
      x < baseX || x > baseX + buttonSymbols.getBaseWidth() + textWidth + 1 ||
      y < baseY || y > baseY + buttonSymbols.getHeight()) {
      return;
    }
    
    String newSymbol = callback.execute();
    if (newSymbol != null) {
      symbol = newSymbol;
    }
  }
}
