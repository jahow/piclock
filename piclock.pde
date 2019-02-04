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
  //screen.addWidget(new TextScreenWidget("ven.", 4, 22));
  //screen.addWidget(new TextScreenWidget("08-02", 4, 29));
  //screen.addWidget(new TextScreenWidget("t°", 34, 22));
  //screen.addWidget(new TextScreenWidget("36", 34, 29));
  //screen.addWidget(new TextScreenWidget("%h", 46, 22));
  //screen.addWidget(new TextScreenWidget("32", 46, 29));
  
  // weather
  screen.addWidget(new WeatherScreenWidget("cloud", 4, 23));
  screen.addWidget(new TextScreenWidget("56", 3, 32));
  screen.addWidget(new WeatherScreenWidget("cloud+", 15, 23));
  screen.addWidget(new TextScreenWidget("47", 14, 32));
  screen.addWidget(new WeatherScreenWidget("cloud++", 26, 23));
  screen.addWidget(new TextScreenWidget("86", 25, 32));
  screen.addWidget(new WeatherScreenWidget("mist", 37, 23));
  screen.addWidget(new TextScreenWidget("19", 36, 32));
  screen.addWidget(new WeatherScreenWidget("rain", 48, 23));
  screen.addWidget(new TextScreenWidget("03", 47, 32));
  
  screen.addWidget(new PointerScreenWidget());
}

void draw() 
{
  background(0);
  screen.draw();
}
