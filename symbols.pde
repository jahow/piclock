public class SymbolSet {
  private int baseWidth;
  private int height;
  private HashMap<String, int[]> symbols;
  private HashMap<String, Integer> symbolsWidth;
  
  SymbolSet(int width, int height) {
    this.baseWidth = width;
    this.height = height;
    symbols = new HashMap<String, int[]>();
    symbolsWidth = new HashMap<String, Integer>();
  }
  
  public int getSymbolWidth(String key) {
    if (!symbolsWidth.containsKey(key)) {
      return baseWidth;
    }
    return symbolsWidth.get(key);
  }
  
  public int getBaseWidth() {
    return baseWidth;
  }
  
  public int getHeight() {
    return height;
  }
  
  public void put(String key, int[] symbol) {
    this.put(key, symbol, baseWidth);
  }
  
  public void put(String key, int[] symbol, int width) {
    if (symbol.length != width * height) {
      println("Invalid symbol size for: " + key);
      return;
    }
    symbols.put(key, symbol);
    symbolsWidth.put(key, width);
  }
  
  public int getSymbolValue(String key, int col, int row) {
    int width = getSymbolWidth(key);
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
  
  textSymbols = new SymbolSet(4, 5);
  textSymbols.put("A", new int[] {
    0, 1, 1, 0,
    1, 0, 0, 1,
    1, 1, 1, 1,
    1, 0, 0, 1,
    1, 0, 0, 1,
  });
  textSymbols.put("M", new int[] {
    0, 1, 0, 1, 0,
    1, 0, 1, 0, 1,
    1, 0, 0, 0, 1,
    1, 0, 0, 0, 1,
    1, 0, 0, 0, 1
  }, 5);
  textSymbols.put("Q", new int[] {
    0, 1, 1, 0,
    1, 0, 0, 1,
    1, 0, 0, 1,
    1, 0, 1, 1,
    0, 1, 1, 1
  });
  textSymbols.put("W", new int[] {
    1, 0, 0, 0, 1,
    1, 0, 0, 0, 1,
    1, 0, 0, 0, 1,
    1, 0, 1, 0, 1,
    0, 1, 0, 1, 0
  }, 5);
  textSymbols.put("P", new int[] {
    1, 1, 1, 0,
    1, 0, 0, 1,
    1, 1, 1, 0,
    1, 0, 0, 0,
    1, 0, 0, 0
  });
  textSymbols.put("0", new int[] {
    0, 1, 1, 0,
    1, 0, 1, 1,
    1, 0, 0, 1,
    1, 1, 0, 1,
    0, 1, 1, 0
  });
  textSymbols.put("1", new int[] {
    1, 1,
    0, 1,
    0, 1,
    0, 1,
    0, 1
  }, 2);
  textSymbols.put("2", new int[] {
    1, 1, 1, 0,
    0, 0, 0, 1,
    0, 1, 1, 0,
    1, 0, 0, 0,
    1, 1, 1, 1
  });
  textSymbols.put("3", new int[] {
    1, 1, 1, 0,
    0, 0, 0, 1,
    0, 0, 1, 1,
    0, 0, 0, 1,
    1, 1, 1, 0
  });
  textSymbols.put("4", new int[] {
    1, 0, 0, 1,
    1, 0, 0, 1,
    1, 1, 1, 1,
    0, 0, 0, 1,
    0, 0, 0, 1
  });
  textSymbols.put("5", new int[] {
    1, 1, 1, 1,
    1, 0, 0, 0,
    1, 1, 1, 0,
    0, 0, 0, 1,
    1, 1, 1, 0
  });
  textSymbols.put("6", new int[] {
    0, 1, 1, 1,
    1, 0, 0, 0,
    1, 1, 1, 0,
    1, 0, 0, 1,
    0, 1, 1, 0
  });
  textSymbols.put("7", new int[] {
    1, 1, 1, 1,
    0, 0, 0, 1,
    0, 0, 0, 1,
    0, 0, 0, 1,
    0, 0, 0, 1
  });
  textSymbols.put("8", new int[] {
    0, 1, 1, 0,
    1, 0, 0, 1,
    0, 1, 1, 0,
    1, 0, 0, 1,
    0, 1, 1, 0
  });
  textSymbols.put("9", new int[] {
    0, 1, 1, 0,
    1, 0, 0, 1,
    0, 1, 1, 1,
    0, 0, 0, 1,
    1, 1, 1, 0
  });
  textSymbols.put(" ", new int[] {
    0, 0, 0, 0,
    0, 0, 0, 0,
    0, 0, 0, 0,
    0, 0, 0, 0,
    0, 0, 0, 0
  });
};
