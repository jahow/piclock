float shutdownProgress = -1;
float SHUTDOWN_END = 150;

void beginShutdown() {
  shutdownProgress = 0;
}

class ShutdownScreenWidget extends ScreenWidget {
  public ShutdownScreenWidget() {
  }
  
  void update() {
    if (shutdownProgress >= 0) {
      shutdownProgress += 1;
    }
    if (shutdownProgress >= SHUTDOWN_END) {
      exec("shutdown", "-h", "now");
      exit();
    }
  }
  
  float drawPixel(int x, int y, float prevState) {
    if (shutdownProgress < 0) {
      return prevState;
    }
    
    String text = "goodbye";
    int halfWidth = floor(getTextSymbolWidth(text) * 0.5);
    int halfHeight = floor(textSymbols.getHeight() * 0.5);
    int baseX = floor(getPixelCountX() * 0.5) - halfWidth;
    int baseY = floor(getPixelCountY() * 0.5) - floor(textSymbols.getHeight() * 0.5);
    
    float scale = min(1, 1.7 * shutdownProgress / SHUTDOWN_END + 0.25);
    float fromCenterX = scale * (x - baseX - halfWidth);
    float fromCenterY = scale * (y - baseY - halfHeight); 
    float value = getTextSymbolValue(text,
        round(fromCenterX + halfWidth),
        round(fromCenterY + halfHeight));
    float opacity = max(0, sin(PI * shutdownProgress / SHUTDOWN_END));
    
    return value * opacity;
  }
  
  public float drawTransformedPixel(int x, int y, float prevState) {
    return drawPixel(x, y, prevState);
  }
}
