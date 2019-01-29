final int SCREEN_WIDTH = 480;
final int SCREEN_HEIGHT = 320;

LcdScreen screen = new LcdScreen();

void setup() 
{
  size(480, 320);
  
  initSymbols();
  screen.init();
  screen.addWidget(new PointerScreenWidget());
  screen.addWidget(new ClockScreenWidget());
}

void draw() 
{
  background(0);
  screen.draw();
}
