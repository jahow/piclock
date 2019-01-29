class TextScreenWidget extends ScreenWidget {
  private String text;
  private int baseX;
  private int baseY;
  
  public TextScreenWidget(String text, int x, int y) {
    this.text = text;
    baseX = x;
    baseY = y;
  }
  
  boolean drawPixel(int x, int y, boolean prevState) {
    int width = textSymbols.getBaseWidth();
    int charIndex = floor((x - baseX) / (width + 1));
    if (charIndex < 0 || charIndex >= this.text.length()) {
      return prevState;
    }
    
    int startX = baseX + charIndex * (width + 1);
    
    int value = textSymbols.getSymbolValue(this.text.substring(charIndex, charIndex + 1), x - startX, y - baseY);
    
    return value > 0 ? true : prevState;
  }
}
