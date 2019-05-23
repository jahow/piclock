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
  //fullScreen();
  // noCursor();
  size(480, 320);
  
  initSymbols();
  loadSettings();
  initAlarm();
  
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
  mainScreen.addWidget(new ScreenWidget() {
    @Override
    public void handleClick(int x, int y, boolean first) {
      if (first) { currentScreen = optionsScreen; }
    }
  });
  
  // OPTIONS SCREEN
  optionsScreen.init();
  
  //optionsScreen.addWidget(new TextScreenWidget("l", 3, 1));
  optionsScreen.addWidget(new AlarmToggleScreenWidget(2, 0, 0));
  optionsScreen.addWidget(new AlarmClockScreenWidget(1, 6, 0));
  
  optionsScreen.addWidget(new AlarmToggleScreenWidget(12, 0, 1));
  optionsScreen.addWidget(new AlarmClockScreenWidget(11, 6, 1));
  
  optionsScreen.addWidget(new AlarmToggleScreenWidget(22, 0, 2));
  optionsScreen.addWidget(new AlarmClockScreenWidget(21, 6, 2));
  
  optionsScreen.addWidget(new AlarmToggleScreenWidget(32, 0, 3));
  optionsScreen.addWidget(new AlarmClockScreenWidget(31, 6, 3));
  
  optionsScreen.addWidget(new AlarmToggleScreenWidget(42, 0, 4));
  optionsScreen.addWidget(new AlarmClockScreenWidget(41, 6, 4));
  
  optionsScreen.addWidget(new AlarmToggleScreenWidget(52, 0, 5));
  optionsScreen.addWidget(new AlarmClockScreenWidget(51, 6, 5));
  
  optionsScreen.addWidget(new ButtonScreenWidget(1, 28, new Callable() {
    @Override
    public String execute() {
      Settings_CurrentRadio = (Settings_CurrentRadio + 1) % Settings_RadioList.size();
      return null;
    }
  }, "note") {
    @Override
    public void update() {
      this.label = Settings_RadioList.get(Settings_CurrentRadio).name;
    }
  });
  
  optionsScreen.addWidget(new ButtonScreenWidget(0, 34, new Callable() {
    @Override
    public String execute() {
      currentScreen = mainScreen;
      saveSettings();
      return null;
    }
  }, "action", "save"));
  optionsScreen.addWidget(new ButtonScreenWidget(40, 34, new Callable() {
    @Override
    public String execute() {
      beginShutdown();
      return null;
    }
  }, "action", "off"));
  
  optionsScreen.addWidget(new ShutdownScreenWidget());
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
  
  updateAlarm();
  
  updateTime();
  
  if (mousePressed && (millis() - mousePressedStart) > 300 && frameCount % 4 == 0) {
    doClick(false);
  }
}

int mousePressedStart = 0;

void mousePressed()
{
  mousePressedStart = millis();
  doClick(true);
}

void doClick(boolean first)
{
  int[] coords = getPixelCoords(mouseX, mouseY);
  currentScreen.handleClick(coords[0], coords[1], first);
}
