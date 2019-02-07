final int[] tempCoords = {0, 0};

// returns the pixel center
int[] getScreenCoords(int pixelX, int pixelY) {
  final int shiftX = 3;
  final int shiftY = 3;
  tempCoords[0] = shiftX + pixelX * (GUTTER + PIXEL_SIZE) + GUTTER + PIXEL_SIZE / 2;
  tempCoords[1] = shiftY + pixelY * (GUTTER + PIXEL_SIZE) + GUTTER + PIXEL_SIZE / 2;
  return tempCoords;
}

int getPixelCountX() {
  return floor((SCREEN_WIDTH - GUTTER) / (GUTTER + PIXEL_SIZE));
}

int getPixelCountY() {
  return floor((SCREEN_HEIGHT - GUTTER) / (GUTTER + PIXEL_SIZE));
}

final HashMap<String, int[]> offsetsMap = new HashMap<String, int[]>();
int getTextSymbolValue(String text, int x, int y) {
  if (y < 0 || y > textSymbols.getHeight()) {
    return 0;
  }
  
  String upperText = text.toUpperCase();
  int[] offsets;
  if (!offsetsMap.containsKey(upperText)) {
    offsets = new int[upperText.length() + 1];
    int offset = 0;
    int gutter = 1;
    for (int i = 0; i < text.length(); i++) {
      offsets[i] = offset;
      offset += textSymbols.getSymbolWidth(upperText.substring(i, i + 1)) + gutter; 
    }
    offsets[upperText.length()] = offset - gutter;
    offsetsMap.put(upperText, offsets);
  } else {
    offsets = offsetsMap.get(upperText);
  }
  
  int charIndex = -1;
  for (int i = 0; i < upperText.length(); i++) {
    if (x >= offsets[i] && x < offsets[i + 1]) {
      charIndex = i;
    }
  }
  
  if (charIndex == -1) { return 0; }
  
  int offsetX = offsets[charIndex];
  return textSymbols.getSymbolValue(upperText.substring(charIndex, charIndex + 1), x - offsetX, y);
}

String pad(String text, int length) {
  return pad(text, length, "0");
}
String pad(String text, int length, String padChar) {
  String result = text;
  while (result.length() < length) {
    result = padChar + result;
  }
  return result;
}
