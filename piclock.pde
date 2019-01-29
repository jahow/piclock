final int SCREEN_WIDTH = 480;
final int SCREEN_HEIGHT = 320;

LcdScreen screen = new LcdScreen();

void setup() 
{
  size(480, 320);
  
  initSymbols();
  screen.init();
  screen.addWidget(new ClockScreenWidget());
  screen.addWidget(new TextScreenWidget("AMQPZW BCDEF", 1, 16));
  screen.addWidget(new TextScreenWidget("0123456789", 1, 25));
  screen.addWidget(new PointerScreenWidget());
}

void draw() 
{
  background(0);
  screen.draw();
}
