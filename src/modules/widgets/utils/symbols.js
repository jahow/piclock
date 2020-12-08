/**
 * @param {SymbolSet} set
 * @param {string} key
 * @return {number}
 */
export function getSymbolWidth(set, key) {
  // missing symbol: return checker pattern
  if (!key in set.symbols) {
    Math.ceil(set.height / 2);
  }
  return set.symbols[key][0];
}

/**
 * @param {SymbolSet} set
 * @param {string} key
 * @param {number} col
 * @param {number} row
 * @return {number}
 */
export function getSymbolValue(set, key, col, row) {
  const width = getSymbolWidth(set, key);

  if (col < 0 || col >= width || row < 0 || row >= set.height) {
    return 0;
  }

  // missing symbol: return checker pattern
  if (!key in set.symbols) {
    return (col % 2 === 0 && row % 2 === 0) || (col % 2 === 1 && row % 2 === 1)
      ? 1
      : 0;
  }

  const symbol = set.symbols[key];
  return symbol[1 + col + row * width];
}

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
