final int SCREEN_WIDTH = 480;
final int SCREEN_HEIGHT = 320;

LcdScreen mainScreen = new LcdScreen();
LcdScreen optionsScreen = new LcdScreen();
LcdScreen currentScreen = mainScreen;

ScreenWidget dateWidget;
ScreenWidget sensorWidget;
ScreenWidget weatherWidget;

void setup() 
{
  fullScreen();
  noCursor();
  
  initSymbols();
  
  // MAIN SCREEN
  mainScreen.init();
  mainScreen.addWidget(new ClockScreenWidget(4, 4));
  
  // day, temp and hr
  dateWidget = new DateScreenWidget(4, 23);
  sensorWidget = new SensorScreenWidget(34, 23);
  mainScreen.addWidget(dateWidget);
  mainScreen.addWidget(sensorWidget);
  
  // weather
  weatherWidget = new WeatherScreenWidget(3, 21);
  mainScreen.addWidget(weatherWidget);
  
  //screen.addWidget(new PointerScreenWidget());
  mainScreen.addWidget(new ButtonScreenWidget(getPixelCountX() - 4, -1, new Callable() {
    @Override
    public String execute() {
      currentScreen = optionsScreen;
      return null;
    }
  }, "simple"));
  
  // OPTIONS SCREEN
  optionsScreen.init();
  //optionsScreen.addWidget(new TextScreenWidget("options", 1, 1));
  
  optionsScreen.addWidget(new TextScreenWidget("l", 3, 1));
  optionsScreen.addWidget(new AlarmClockScreenWidget(1, 8, 0));
  
  optionsScreen.addWidget(new TextScreenWidget("m", 12, 1));
  optionsScreen.addWidget(new AlarmClockScreenWidget(11, 8, 1));
  
  optionsScreen.addWidget(new TextScreenWidget("m", 22, 1));
  optionsScreen.addWidget(new AlarmClockScreenWidget(21, 8, 2));
  
  optionsScreen.addWidget(new TextScreenWidget("j", 33, 1));
  optionsScreen.addWidget(new AlarmClockScreenWidget(31, 8, 3));
  
  optionsScreen.addWidget(new TextScreenWidget("v", 42, 1));
  optionsScreen.addWidget(new AlarmClockScreenWidget(41, 8, 4));
  
  optionsScreen.addWidget(new TextScreenWidget("s", 52, 1));
  optionsScreen.addWidget(new AlarmClockScreenWidget(51, 8, 5));
  
}

void draw() 
{
  background(0);
  
  //float animRatio = 0.5 - 0.5 * cos(millis() * 0.003);
  int period = 12000;
  float slope = 0.0013;
  int remaining = millis() % period;
  float animRatio = 0.5 + 0.5 * cos(PI * max(0, min(1,
    remaining < period / 2 ?
      -0.25 * slope * period + 0.5 + slope * remaining :
      0.75 * slope * period + 0.5 - slope * remaining
  )));
  
  // update widgets
  dateWidget.translate(0, round(-8 * animRatio));
  dateWidget.setOpacity(1.0 - animRatio);
  sensorWidget.translate(0, round(-8 * animRatio));
  sensorWidget.setOpacity(1.0 - animRatio);
  
  weatherWidget.translate(0, round(8 * (1 - animRatio)));
  weatherWidget.setOpacity(animRatio);
  
  currentScreen.draw();
  
  if (mousePressed && (millis() - mousePressedStart) > 300 && frameCount % 4 == 0) {
    doClick();
  }
}

int mousePressedStart = 0;

void mousePressed()
{
  mousePressedStart = millis();
  doClick();
}

void doClick()
{
  int[] coords = getPixelCoords(mouseX, mouseY);
  currentScreen.handleClick(coords[0], coords[1]);
}
