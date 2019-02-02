final int GUTTER = 2;
final int PIXEL_SIZE = 8;
final int GLOW_RADIUS = 4;
final float GLOW_RATIO = 0.25;

class LcdScreen {
  final int screenWidth = getPixelCountX();
  final int screenHeight = getPixelCountY();
  final float[] screenState = new float[screenWidth * screenHeight];
  final boolean[] screenStateCommand = new boolean[screenWidth * screenHeight];
  ArrayList<ScreenWidget> widgets = new ArrayList<ScreenWidget>();
  
  LcdScreen() {
  }
  
  void init() {
    for (int i = 0; i < screenState.length; i++) {
      screenState[i] = 0.0;
      screenStateCommand[i] = false;
    }
  }
  
  void draw() {
    int i, j, k, x, y;
    
    // reset command
    for (i = 0; i < screenState.length; i++) {
      screenStateCommand[i] = false;
    }
    
    // draw widgets
    for(ScreenWidget widget : widgets) {
      for (i = 0; i < screenState.length; i++) {
        x = i % screenWidth;
        y = floor(i / screenWidth);
        
        screenStateCommand[i] = widget.drawPixel(x, y, screenStateCommand[i]);
      }
    }
    
    // update pixels
    noStroke();
    rectMode(RADIUS);
    for (i = 0; i < screenState.length; i++) {
      x = i % screenWidth;
      y = floor(i / screenWidth);
      
      if (screenStateCommand[i]) {
        screenState[i] = 1 - (1 - screenState[i]) * 0.7;
      } else {
        screenState[i] *= 0.9;
      }
    }
    
    // draw pixels with glow
    int[] coords;
    float radius, state, stateGlow;
    noStroke();
    rectMode(RADIUS);
    for (i = 0; i < screenState.length; i++) {
      x = i % screenWidth;
      y = floor(i / screenWidth);
      coords = getScreenCoords(x, y);
      state = screenState[i];
      radius = PIXEL_SIZE * 0.5 + 0.5 * sin(state * PI) + 0.4 * state;
      
      for(j = max(0, x - GLOW_RADIUS); j <= min(screenWidth - 1, x + GLOW_RADIUS); j++) {
        for(k = max(0, y - GLOW_RADIUS); k <= min(screenHeight - 1, y + GLOW_RADIUS); k++) {
          stateGlow = screenState[j + k * screenWidth];
          if (screenStateCommand[j + k * screenWidth]) {
            state = max(state,
              min(
                stateGlow * GLOW_RATIO * (1 - pow(abs(j - x) * 1.0) / GLOW_RADIUS, 2),
                stateGlow * GLOW_RATIO * (1 - ow(abs(k - y) * 1.0) / GLOW_RADIUS, 2)
              )
            );
          }
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
