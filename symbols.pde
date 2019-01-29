public class SymbolSet {
  private int width;
  private int height;
  private HashMap<String, int[]> symbols;
  
  SymbolSet(int width, int height) {
    this.width = width;
    this.height = height;
    symbols = new HashMap<String, int[]>();
  }
  
  public int getWidth() {
    return width;
  }
  
  public int getHeight() {
    return height;
  }
  
  public void put(String key, int[] symbol) {
    if (symbol.length != width * height) {
      println("Invalid symbol size for: " + key);
      return;
    }
    symbols.put(key, symbol);
  }
  
  public int getSymbolValue(String key, int col, int row) {
    if (col < 0 || col >= width || row < 0 || row >= height) {
      return 0;
    }
    if (!symbols.containsKey(key)) {
      return (col % 2 == 0 && row % 2 == 0) ||
       (col % 2 == 1 && row % 2 == 1)? 1 : 0;
    }
    return symbols.get(key)[col + row * width];
  }
}

SymbolSet clockSymbols;
SymbolSet textSymbols;
SymbolSet weatherSymbols;

void initSymbols() {
  clockSymbols = new SymbolSet(6, 8);
  clockSymbols.put("0", new int[] {
    0, 1, 1, 1, 1, 0,
    1, 1, 1, 1, 1, 1,
    1, 1, 0, 0, 1, 1,
    1, 1, 0, 0, 1, 1,
    1, 1, 0, 0, 1, 1,
    1, 1, 0, 0, 1, 1,
    1, 1, 1, 1, 1, 1,
    0, 1, 1, 1, 1, 0
  });
  clockSymbols.put("1", new int[] {
    0, 0, 0, 1, 1, 1,
    0, 0, 0, 1, 1, 1,
    0, 0, 0, 0, 1, 1,
    0, 0, 0, 0, 1, 1,
    0, 0, 0, 0, 1, 1,
    0, 0, 0, 0, 1, 1,
    0, 0, 0, 0, 1, 1,
    0, 0, 0, 0, 1, 1
  });
  clockSymbols.put("2", new int[] {
    1, 1, 1, 1, 1, 0,
    1, 1, 1, 1, 1, 1,
    0, 0, 0, 0, 1, 1,
    0, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 0,
    1, 1, 0, 0, 0, 0,
    1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1
  });
  clockSymbols.put("3", new int[] {
    1, 1, 1, 1, 1, 0,
    1, 1, 1, 1, 1, 1,
    0, 0, 0, 0, 1, 1,
    0, 0, 1, 1, 1, 1,
    0, 0, 1, 1, 1, 1,
    0, 0, 0, 0, 1, 1,
    1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 0
  });
  clockSymbols.put("4", new int[] {
    1, 1, 0, 0, 1, 1,
    1, 1, 0, 0, 1, 1,
    1, 1, 0, 0, 1, 1,
    1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1,
    0, 0, 0, 0, 1, 1,
    0, 0, 0, 0, 1, 1,
    0, 0, 0, 0, 1, 1
  });
  clockSymbols.put("5", new int[] {
    1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1,
    1, 1, 0, 0, 0, 0,
    1, 1, 1, 1, 1, 0,
    1, 1, 1, 1, 1, 1,
    0, 0, 0, 0, 1, 1,
    1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1
  });
  clockSymbols.put("6", new int[] {
    0, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1,
    1, 1, 0, 0, 0, 0,
    1, 1, 1, 1, 1, 0,
    1, 1, 1, 1, 1, 1,
    1, 1, 0, 0, 1, 1,
    1, 1, 1, 1, 1, 1,
    0, 1, 1, 1, 1, 0
  });
  clockSymbols.put("7", new int[] {
    1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1,
    0, 0, 0, 0, 1, 1,
    0, 0, 0, 0, 1, 1,
    0, 0, 0, 0, 1, 1,
    0, 0, 0, 0, 1, 1,
    0, 0, 0, 0, 1, 1,
    0, 0, 0, 0, 1, 1
  });
  clockSymbols.put("8", new int[] {
    0, 1, 1, 1, 1, 0,
    1, 1, 1, 1, 1, 1,
    1, 1, 0, 0, 1, 1,
    1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1,
    1, 1, 0, 0, 1, 1,
    1, 1, 1, 1, 1, 1,
    0, 1, 1, 1, 1, 0
  });
  clockSymbols.put("9", new int[] {
    0, 1, 1, 1, 1, 0,
    1, 1, 1, 1, 1, 1,
    1, 1, 0, 0, 1, 1,
    1, 1, 1, 1, 1, 1,
    0, 1, 1, 1, 1, 1,
    0, 0, 0, 0, 1, 1,
    1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 0
  });
  clockSymbols.put("up", new int[] {
    0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0,
    0, 0, 1, 1, 0, 0,
    0, 0, 1, 1, 0, 0,
    0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0
  });
  clockSymbols.put("down", new int[] {
    0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0,
    0, 0, 1, 1, 0, 0,
    0, 0, 1, 1, 0, 0,
    0, 0, 0, 0, 0, 0
  });
};