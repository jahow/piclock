final int SCREEN_WIDTH = 480;
final int SCREEN_HEIGHT = 320;

LcdScreen screen = new LcdScreen();
ScreenWidget dateWidget;
ScreenWidget sensorWidget;
ScreenWidget weatherWidget;

void setup() 
{
  size(480, 320);
  
  initSymbols();
  screen.init();
  
  screen.addWidget(new ClockScreenWidget(4, 4));
  
  // day, temp and hr
  dateWidget = new DateScreenWidget(4, 23);
  sensorWidget = new SensorScreenWidget(34, 23);
  screen.addWidget(dateWidget);
  screen.addWidget(sensorWidget);
  
  // weather
  weatherWidget = new WeatherScreenWidget(3, 21);
  screen.addWidget(weatherWidget);
  
  screen.addWidget(new PointerScreenWidget());
}

void draw() 
{
  background(0);
  
  float animRatio = 0.5 - 0.5 * cos(millis() * 0.003);
  
  // update widgets
  dateWidget.translate(0, round(-8 * animRatio));
  dateWidget.setOpacity(1.0 - animRatio);
  sensorWidget.translate(0, round(-8 * animRatio));
  sensorWidget.setOpacity(1.0 - animRatio);
  
  weatherWidget.translate(0, round(8 * (1 - animRatio)));
  weatherWidget.setOpacity(animRatio);
  
  screen.draw();
}
