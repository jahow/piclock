class AlarmToggleScreenWidget extends ButtonScreenWidget {
  int day;
  
  AlarmToggleScreenWidget(int x, int y, int day) {
    super(x, y, new Callable(), "disabled");
    this.day = day;
  }
  
  @Override
  public void handleClick(int x, int y, boolean first) {
    if (!first ||
      x < baseX || x > baseX + buttonSymbols.getBaseWidth() ||
      y < baseY || y > baseY + buttonSymbols.getHeight()) {
      return;
    }
    
    Settings_AlarmEnabled[this.day] = !Settings_AlarmEnabled[this.day];
    symbol = Settings_AlarmEnabled[this.day] ? "enabled" : "disabled";
  }
}
