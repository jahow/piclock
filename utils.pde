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
