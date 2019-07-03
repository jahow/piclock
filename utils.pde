import java.util.Date;
import java.util.Calendar;
import java.util.TimeZone;

final int[] tempCoords = {0, 0};
final int SHIFTX = 3;
final int SHIFTY = 3;

// returns the pixel center
int[] getScreenCoords(int pixelX, int pixelY) {
  tempCoords[0] = SHIFTX + pixelX * (GUTTER + PIXEL_SIZE) + GUTTER + PIXEL_SIZE / 2;
  tempCoords[1] = SHIFTY + pixelY * (GUTTER + PIXEL_SIZE) + GUTTER + PIXEL_SIZE / 2;
  return tempCoords;
}

int[] getPixelCoords(int screenX, int screenY) {
  tempCoords[0] = floor((screenX - SHIFTX) / (GUTTER + PIXEL_SIZE));
  tempCoords[1] = floor((screenY - SHIFTY) / (GUTTER + PIXEL_SIZE));
  return tempCoords;
}

int getPixelCountX() {
  return floor((SCREEN_WIDTH - GUTTER) / (GUTTER + PIXEL_SIZE));
}

int getPixelCountY() {
  return floor((SCREEN_HEIGHT - GUTTER) / (GUTTER + PIXEL_SIZE));
}

final HashMap<String, int[]> offsetsMap = new HashMap<String, int[]>();
int[] getTextSymbolOffsets(String text) {
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
  return offsets;
}
int getTextSymbolValue(String text, int x, int y) {
  if (y < 0 || y > textSymbols.getHeight()) {
    return 0;
  }
  
  String upperText = text.toUpperCase();
  int[] offsets = getTextSymbolOffsets(text);
  
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
int getTextSymbolWidth(String text) {
  int[] offsets = getTextSymbolOffsets(text);
  return offsets[offsets.length - 1];
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

// this is used by anyone who wants date info
Calendar currentDay = Calendar.getInstance(TimeZone.getDefault());
int lastTimeUpdate = 0;

void updateTime() {
  int current = millis();
  if (current - lastTimeUpdate > 60000) {
    currentDay.setTime(new Date());
    lastTimeUpdate = current;
    //println("updating calendar");
  }
}

color[] screenColors = new color[]{
  #95D9FA,
  #95FAF2,
  #EAFA95,
  #FFFB7C,
  #FFDA7C,
  #FFD5A2,
  #EDBCFF,
  #D3BCFF
};

color getScreenColor(int x, int y) {
  //float n = noise(x * 0.15, y * 0.15) * 100 + millis()* 0.004;
  //float hue = (floor(n / 20.0) * 20.0) % 100;
  float colorIndex = (millis() * 0.0001) % screenColors.length;
  float ratio = colorIndex % 1;
  int indexA = floor(colorIndex) % screenColors.length;
  int indexB = (indexA + 1) % screenColors.length;
  int indexC = (indexA + 2) % screenColors.length;
  color a = lerpColor(screenColors[indexA], screenColors[indexB], ratio);
  color b = lerpColor(screenColors[indexB], screenColors[indexC], ratio);
  float noiseRatio = noise(x * 0.05, y * 0.05, millis() * 0.0001)  + millis()* 0.0001;
  return lerpColor(a, b, noiseRatio);
}
