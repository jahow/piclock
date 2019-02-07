final int SCREEN_WIDTH = 480;
final int SCREEN_HEIGHT = 320;

LcdScreen screen = new LcdScreen();

void setup() 
{
  size(480, 320);
  
  initSymbols();
  screen.init();
  screen.addWidget(new ClockScreenWidget(4, 4));
  
  // day, temp and hr
  screen.addWidget(new DateScreenWidget(4, 22));
  screen.addWidget(new SensorScreenWidget(34, 22));
  
  // weather
  //screen.addWidget(new WeatherScreenWidget(3, 23));
  
  screen.addWidget(new PointerScreenWidget());
}

void draw() 
{
  background(0);
  screen.draw();
}
