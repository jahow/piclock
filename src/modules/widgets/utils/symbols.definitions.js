/**
 * @param {string[]} symbolAsStrings
 * @return {Object<string, number[]>} symbols Symbol width is the first value
 */
function processSymbol(symbolAsStrings) {
  const symbolWidth = symbolAsStrings.reduce(
    (prev, curr) => Math.max(prev, curr.length),
    0
  );
  return symbolAsStrings.reduce(
    (prev, curr) => {
      return [
        ...prev,
        ...curr
          .padEnd(symbolWidth, ' ')
          .split('')
          .map((char) => (char !== ' ' ? 1 : 0)),
      ];
    },
    [symbolWidth]
  );
}

/**
 * @typedef {Object} SymbolSet
 * @property {number} baseWidth
 * @property {number} height
 * @property {Object<string, number[]>} symbols Symbol width is the first number here
 */

/** @type {SymbolSet} */
export const clockSymbols = {
  baseWidth: 9,
  height: 15,
  symbols: {
    0: processSymbol([
      ' xxxxxxx ',
      'xxxxxxxxx',
      'xxxxxxxxx',
      'xxx   xxx',
      'xxx   xxx',
      'xxx   xxx',
      'xxx   xxx',
      'xxx   xxx',
      'xxx   xxx',
      'xxx   xxx',
      'xxx   xxx',
      'xxx   xxx',
      'xxxxxxxxx',
      'xxxxxxxxx',
      ' xxxxxxx ',
    ]),
    1: processSymbol([
      '   xxxxx ',
      '   xxxxxx',
      '   xxxxxx',
      '      xxx',
      '      xxx',
      '      xxx',
      '      xxx',
      '      xxx',
      '      xxx',
      '      xxx',
      '      xxx',
      '      xxx',
      '      xxx',
      '      xxx',
      '      xxx',
    ]),
    2: processSymbol([
      'xxxxxxxx ',
      'xxxxxxxxx',
      'xxxxxxxxx',
      '      xxx',
      '      xxx',
      '      xxx',
      ' xxxxxxxx',
      'xxxxxxxxx',
      'xxxxxxxx ',
      'xxx      ',
      'xxx      ',
      'xxx      ',
      'xxxxxxxxx',
      'xxxxxxxxx',
      'xxxxxxxxx',
    ]),
    3: processSymbol([
      'xxxxxxxx ',
      'xxxxxxxxx',
      'xxxxxxxxx',
      '      xxx',
      '      xxx',
      '      xxx',
      'xxxxxxxxx',
      'xxxxxxxxx',
      'xxxxxxxxx',
      '      xxx',
      '      xxx',
      '      xxx',
      'xxxxxxxxx',
      'xxxxxxxxx',
      'xxxxxxxx ',
    ]),
    4: processSymbol([
      'xxx   xxx',
      'xxx   xxx',
      'xxx   xxx',
      'xxx   xxx',
      'xxx   xxx',
      'xxx   xxx',
      'xxxxxxxxx',
      'xxxxxxxxx',
      'xxxxxxxxx',
      '      xxx',
      '      xxx',
      '      xxx',
      '      xxx',
      '      xxx',
      '      xxx',
    ]),
    5: processSymbol([
      'xxxxxxxxx',
      'xxxxxxxxx',
      'xxxxxxxxx',
      'xxx      ',
      'xxx      ',
      'xxx      ',
      'xxxxxxxx ',
      'xxxxxxxxx',
      'xxxxxxxxx',
      '      xxx',
      '      xxx',
      '      xxx',
      'xxxxxxxxx',
      'xxxxxxxxx',
      'xxxxxxxx ',
    ]),
    6: processSymbol([
      ' xxxxxxx ',
      'xxxxxxxxx',
      'xxxxxxxxx',
      'xxx      ',
      'xxx      ',
      'xxx      ',
      'xxxxxxxx ',
      'xxxxxxxxx',
      'xxxxxxxxx',
      'xxx   xxx',
      'xxx   xxx',
      'xxx   xxx',
      'xxxxxxxxx',
      'xxxxxxxxx',
      ' xxxxxxx ',
    ]),
    7: processSymbol([
      'xxxxxxxx ',
      'xxxxxxxxx',
      'xxxxxxxxx',
      '      xxx',
      '      xxx',
      '      xxx',
      '      xxx',
      '      xxx',
      '      xxx',
      '      xxx',
      '      xxx',
      '      xxx',
      '      xxx',
      '      xxx',
      '      xxx',
    ]),
    8: processSymbol([
      ' xxxxxxx ',
      'xxxxxxxxx',
      'xxxxxxxxx',
      'xxx   xxx',
      'xxx   xxx',
      'xxx   xxx',
      'xxxxxxxxx',
      'xxxxxxxxx',
      'xxxxxxxxx',
      'xxx   xxx',
      'xxx   xxx',
      'xxx   xxx',
      'xxxxxxxxx',
      'xxxxxxxxx',
      ' xxxxxxx ',
    ]),
    9: processSymbol([
      ' xxxxxxx ',
      'xxxxxxxxx',
      'xxxxxxxxx',
      'xxx   xxx',
      'xxx   xxx',
      'xxx   xxx',
      'xxxxxxxxx',
      'xxxxxxxxx',
      ' xxxxxxxx',
      '      xxx',
      '      xxx',
      '      xxx',
      'xxxxxxxxx',
      'xxxxxxxxx',
      'xxxxxxxx ',
    ]),
    ':': processSymbol([
      '   ',
      '   ',
      '   ',
      'xxx',
      'xxx',
      'xxx',
      '   ',
      '   ',
      '   ',
      'xxx',
      'xxx',
      'xxx',
      '   ',
      '   ',
      '   ',
    ]),
  },
};

/** @type {SymbolSet} */
export const textSymbols = {
  baseWidth: 4,
  height: 6,
  symbols: {
    // prettier-ignore
    A: processSymbol([
      '    ',
      ' xx ',
      'x  x',
      'x  x',
      ' xxx',
      '    '
    ]),
    // prettier-ignore
    B: processSymbol([
      'x   ',
      'xxx ',
      'x  x',
      'x  x',
      ' xx ',
      '    '
    ]),
    // prettier-ignore
    C: processSymbol([
      '    ',
      ' xx ',
      'x   ',
      'x   ',
      ' xxx',
      '    '
    ]),
    // prettier-ignore
    D: processSymbol([
      '   x',
      ' xxx',
      'x  x',
      'x  x',
      ' xx ',
      '    '
    ]),
    // prettier-ignore
    E: processSymbol([
      '    ',
      ' xx ',
      'xxxx',
      'x   ',
      ' xxx',
      '    '
    ]),
    // prettier-ignore
    F: processSymbol([
      '  x',
      ' x ',
      'xxx',
      ' x ',
      ' x ',
      ' x '
    ]),
    // prettier-ignore
    G: processSymbol([
      '    ',
      ' xx ',
      'x  x',
      ' xxx',
      '   x',
      'xxx '
    ]),
    // prettier-ignore
    H: processSymbol([
      'x   ',
      'x   ',
      'xxx ',
      'x  x',
      'x  x',
      '    '
    ]),
    // prettier-ignore
    I: processSymbol([
      'x ',
      '  ',
      'x ',
      'x ',
      ' x',
      '   '
    ]),
    // prettier-ignore
    J: processSymbol([
      '  x',
      '   ',
      '  x',
      '  x',
      '  x',
      'xx '
    ]),
    // prettier-ignore
    K: processSymbol([
      'x  ',
      'x  ',
      'x x',
      'xx ',
      'x x',
      '   '
    ]),
    // prettier-ignore
    L: processSymbol([
      'x  ',
      'x  ',
      'x  ',
      'x  ',
      ' xx',
      '   '
    ]),
    // prettier-ignore
    M: processSymbol([
      '     ',
      'xx x ',
      'x x x',
      'x   x',
      'x   x',
      '     '
    ]),
    // prettier-ignore
    N: processSymbol([
      '    ',
      'x x ',
      'xx x',
      'x  x',
      'x  x',
      '    '
    ]),
    // prettier-ignore
    O: processSymbol([
      '    ',
      ' xx ',
      'x  x',
      'x  x',
      ' xx ',
      '    '
    ]),
    // prettier-ignore
    P: processSymbol([
      '    ',
      ' xx ',
      'x  x',
      'x  x',
      'xxx ',
      'x   '
    ]),
    // prettier-ignore
    Q: processSymbol([
      '    ',
      ' xx ',
      'x  x',
      'x  x',
      ' xxx',
      '   x'
    ]),
    // prettier-ignore
    R: processSymbol([
      '   ',
      'x x',
      'xx ',
      'x  ',
      'x  ',
      '   '
    ]),
    // prettier-ignore
    S: processSymbol([
      '    ',
      ' xx ',
      'xxx ',
      '   x',
      'xxx ',
      '    '
    ]),
    // prettier-ignore
    T: processSymbol([
      'x  ',
      'xx ',
      'x  ',
      'x  ',
      ' xx',
      '   '
    ]),
    // prettier-ignore
    U: processSymbol([
      '    ',
      'x  x',
      'x  x',
      'x  x',
      ' xxx',
      '    '
    ]),
    // prettier-ignore
    V: processSymbol([
      '    ',
      'x  x',
      'x  x',
      'x x ',
      ' x  ',
      '    '
    ]),
    // prettier-ignore
    W: processSymbol([
      '     ',
      'x   x',
      'x   x',
      'x x x',
      ' x x ',
      '     '
    ]),
    // prettier-ignore
    X: processSymbol([
      '    ',
      'x  x',
      ' xx ',
      ' xx ',
      'x  x',
      '    '
    ]),
    // prettier-ignore
    Y: processSymbol([
      '    ',
      'x  x',
      'x  x',
      ' xxx',
      '   x',
      ' xx '
    ]),
    // prettier-ignore
    Z: processSymbol([
      '    ',
      'xxxx',
      '  x ',
      ' x  ',
      'xxxx',
      '    '
    ]),
    // prettier-ignore
    0: processSymbol([
      ' xx ',
      'x  x',
      'x  x',
      'x  x',
      ' xx ',
      '    '
    ]),
    // prettier-ignore
    1: processSymbol([
      'xx',
      ' x',
      ' x',
      ' x',
      ' x',
      '  '
    ]),
    // prettier-ignore
    2: processSymbol([
      'xxx ',
      '   x',
      ' xx ',
      'x   ',
      'xxxx',
      '    '
    ]),
    // prettier-ignore
    3: processSymbol([
      'xxx ',
      '   x',
      '  xx',
      '   x',
      'xxx ',
      '    '
    ]),
    // prettier-ignore
    4: processSymbol([
      'x  x',
      'x  x',
      'xxxx',
      '   x',
      '   x',
      '    '
    ]),
    // prettier-ignore
    5: processSymbol([
      'xxxx',
      'x   ',
      'xxx ',
      '   x',
      'xxx ',
      '    '
    ]),
    // prettier-ignore
    6: processSymbol([
      ' xx ',
      'x   ',
      'xxx ',
      'x  x',
      ' xx ',
      '    '
    ]),
    // prettier-ignore
    7: processSymbol([
      'xxxx',
      '   x',
      '   x',
      '   x',
      '   x',
      '    '
    ]),
    // prettier-ignore
    8: processSymbol([
      ' xx ',
      'x  x',
      ' xx ',
      'x  x',
      ' xx ',
      '    '
    ]),
    // prettier-ignore
    9: processSymbol([
      ' xx ',
      'x  x',
      ' xxx',
      '   x',
      ' xx ',
      '    '
    ]),
    // prettier-ignore
    ' ': processSymbol([
      '    ',
      '    ',
      '    ',
      '    ',
      '    ',
      '    '
    ]),
    // prettier-ignore
    '%': processSymbol([
      '    ',
      'x  x',
      '  x ',
      ' x  ',
      'x  x',
      '    '
    ]),
    // prettier-ignore
    '°': processSymbol([
      ' x ',
      'x x',
      ' x ',
      '   ',
      '   ',
      '   '
    ]),
    // prettier-ignore
    '.': processSymbol([
      ' ',
      ' ',
      ' ',
      ' ',
      'x',
      ' '
    ]),
    // prettier-ignore
    '-': processSymbol([
      '  ',
      '  ',
      'xx',
      '  ',
      '  ',
      '  '
    ]),
    // prettier-ignore
    ':': processSymbol([
      ' ',
      ' ',
      'x',
      ' ',
      'x',
      ' '
    ]),
    // prettier-ignore
    '!': processSymbol([
      'x',
      'x',
      'x',
      ' ',
      'x',
      ' '
    ]),
    // prettier-ignore
    '?': processSymbol([
      'xx ',
      '  x',
      ' x ',
      '   ',
      ' x ',
      '   '
    ]),
  },
};
