final int GUTTER = 2;
final int PIXEL_SIZE = 6;
final int GLOW_RADIUS = 4;
final float GLOW_RATIO = 0.17;

class LcdScreen {
  final int screenWidth = getPixelCountX();
  final int screenHeight = getPixelCountY();
  final float[] screenState = new float[screenWidth * screenHeight];
  final float[] screenStateCommand = new float[screenWidth * screenHeight];
  ArrayList<ScreenWidget> widgets = new ArrayList<ScreenWidget>();
  
  LcdScreen() {
    println("screen is " + screenWidth + "x" + screenHeight + " px");
  }
  
  void init() {
    for (int i = 0; i < screenState.length; i++) {
      screenState[i] = 0.0;
      screenStateCommand[i] = 0.0;
    }
  }
  
  void draw() {
    int i, j, k, x, y;
    
    // reset command
    for (i = 0; i < screenState.length; i++) {
      screenStateCommand[i] = 0.0;
    }
    
    // draw widgets
    for(ScreenWidget widget : widgets) {
      for (i = 0; i < screenState.length; i++) {
        x = i % screenWidth;
        y = floor(i / screenWidth);
        
        screenStateCommand[i] = widget.drawTransformedPixel(x, y, screenStateCommand[i]);
      }
    }
    
    // update pixels
    noStroke();
    rectMode(RADIUS);
    float cmd;
    for (i = 0; i < screenState.length; i++) {
      x = i % screenWidth;
      y = floor(i / screenWidth);
      cmd = screenStateCommand[i];
      
      if (cmd > screenState[i]) {
        screenState[i] = cmd - (cmd - screenState[i]) * 0.7;
      } else {
        screenState[i] = cmd - (cmd - screenState[i]) * 0.9;
      }
    }
    
    // draw pixels with glow
    int[] coords;
    float radius, state, stateGlow, xGlow, yGlow;
    noStroke();
    rectMode(RADIUS);
    for (i = 0; i < screenState.length; i++) {
      x = i % screenWidth;
      y = floor(i / screenWidth);
      coords = getScreenCoords(x, y);
      state = screenState[i];
      radius = PIXEL_SIZE * 0.5 + 0.5 * sin(state * PI) + 0.5 * state;
      
      for(j = max(0, x - GLOW_RADIUS); j <= min(screenWidth - 1, x + GLOW_RADIUS); j++) {
        for(k = max(0, y - GLOW_RADIUS); k <= min(screenHeight - 1, y + GLOW_RADIUS); k++) {
          stateGlow = screenState[j + k * screenWidth];
          xGlow = pow(abs(j - x) * 1.0 / GLOW_RADIUS, 2);
          yGlow = pow(abs(k - y) * 1.0 / GLOW_RADIUS, 2);
          state = max(state,
            stateGlow * GLOW_RATIO * (1 - sqrt(xGlow * xGlow + yGlow * yGlow))
          );
        }  
      }
      
      // draw
      fill(this.getPixelColor(x, y, state));
      rect(coords[0], coords[1], radius, radius);
    }
  }
  
  color getPixelColor(int x, int y, float state) {
    return lerpColor(color(0), color(200, 210, 255), state);
  }
  
  void addWidget(ScreenWidget widget) {
    widgets.add(widget);
  }
}
