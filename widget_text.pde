class TextScreenWidget extends ScreenWidget {
  private String text;
  private int baseX;
  private int baseY;
  private int[] charOffsets;
  
  public TextScreenWidget(String text, int x, int y) {
    this.text = text;
    baseX = x;
    baseY = y;
    charOffsets = new int[text.length() + 1];
    int offset = 0;
    int gutter = 1;
    for (int i = 0; i < text.length(); i++) {
      charOffsets[i] = offset;
      offset += textSymbols.getSymbolWidth(text.substring(i, i + 1)) + gutter; 
    }
    charOffsets[text.length()] = offset;
  }
  
  boolean drawPixel(int x, int y, boolean prevState) {
    int charIndex = -1;
    for (int i = 0; i < text.length(); i++) {
      if (x - baseX >= charOffsets[i] && x - baseX < charOffsets[i + 1]) {
        charIndex = i;
      }
    }
    
    if (charIndex == -1) {
      return prevState;
    }
    
    int offsetX = baseX + charOffsets[charIndex];
    int value = textSymbols.getSymbolValue(this.text.substring(charIndex, charIndex + 1), x - offsetX, y - baseY);
    
    return value > 0 ? true : prevState;
  }
}
