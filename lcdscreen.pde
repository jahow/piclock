final int GUTTER = 2;
final int PIXEL_SIZE = 8;

class LcdScreen {
  final int screenWidth = floor((SCREEN_WIDTH - GUTTER) / (GUTTER + PIXEL_SIZE));
  final int screenHeight = floor((SCREEN_HEIGHT - GUTTER) / (GUTTER + PIXEL_SIZE));
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
    int i, x, y;
    
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
    
    // draw pixels
    int[] coords;
    float radius, state;
    noStroke();
    rectMode(RADIUS);
    for (i = 0; i < screenState.length; i++) {
      x = i % screenWidth;
      y = floor(i / screenWidth);
      coords = getScreenCoords(x, y);
      state = screenState[i];
      radius = PIXEL_SIZE * 0.5 + 0.5 * sin(state * PI) + 0.4 * state;
      
      // draw
      fill(this.getPixelColor(x, y, state));
      rect(coords[0], coords[1], radius, radius);
      
      // update
      if (screenStateCommand[i]) {
        screenState[i] = 1 - (1 - state) * 0.7;
      } else {
        screenState[i] *= 0.9;
      }
    }
  }
  
  color getPixelColor(int x, int y, float state) {
    return lerpColor(color(30, 40, 50), color(200, 210, 255), state);
  }
  
  void addWidget(ScreenWidget widget) {
    widgets.add(widget);
  }
}
