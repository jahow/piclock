class TextScreenWidget extends ScreenWidget {  
  private String text;
  private int baseX;
  private int baseY;
  private int[] charOffsets;
  private int startTime = millis();
  
  public TextScreenWidget(String text, int x, int y) {
    this.text = text.toUpperCase();
    
    baseX = x;
    baseY = y;
    charOffsets = new int[text.length() + 1];
    int offset = 0;
    int gutter = 1;
    for (int i = 0; i < text.length(); i++) {
      charOffsets[i] = offset;
      offset += textSymbols.getSymbolWidth(this.text.substring(i, i + 1)) + gutter; 
    }
    charOffsets[text.length()] = offset - gutter;
  }
  
  int getTotalWidth() {
    return charOffsets[charOffsets.length - 1];
  }
  
  float drawPixel(int x, int y, float prevState) {
    int overflowX = max(0, baseX + this.getTotalWidth() - getPixelCountX());
    //int shiftedX = overflowX > 0 ? x + floor((millis() - startTime) / 500) % overflowX : x;
    int shiftedX = x;
    
    int charIndex = -1;
    for (int i = 0; i < text.length(); i++) {
      if (shiftedX - baseX >= charOffsets[i] && shiftedX - baseX < charOffsets[i + 1]) {
        charIndex = i;
      }
    }
    
    if (charIndex == -1) {
      return prevState;
    }
    
    int offsetX = baseX + charOffsets[charIndex];
    int value = textSymbols.getSymbolValue(this.text.substring(charIndex, charIndex + 1), shiftedX - offsetX, y - baseY);
    
    return value > 0 ? 1.0 : prevState;
  }
}
