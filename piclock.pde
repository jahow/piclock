final int SCREEN_WIDTH = 480;
final int SCREEN_HEIGHT = 320;

LcdScreen screen = new LcdScreen();

void setup() 
{
  size(480, 320);
  
  initSymbols();
  screen.init();
  screen.addWidget(new ClockScreenWidget(4, 4));
  screen.addWidget(new TextScreenWidget("ven.", 4, 22));
  screen.addWidget(new TextScreenWidget("08-02", 4, 29));
  screen.addWidget(new TextScreenWidget("t°", 34, 22));
  screen.addWidget(new TextScreenWidget("36", 34, 29));
  screen.addWidget(new TextScreenWidget("%h", 46, 22));
  screen.addWidget(new TextScreenWidget("32", 46, 29));
  screen.addWidget(new PointerScreenWidget());
}

void draw() 
{
  background(0);
  screen.draw();
}
