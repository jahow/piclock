import { getSymbolChainValue } from './utils/symbols';
import { textSymbols } from './utils/symbols.definitions';

/**
 * @param {number} baseX
 * @param {number} baseY
 * @param {string} text
 * @param {number} color
 * @return {Widget}
 */
export function textWidget(baseX, baseY, text, color) {
  const chars = text.toUpperCase().split('');

  return {
    render(x, y, prevColor) {
      const value = getSymbolChainValue(
        textSymbols,
        chars,
        1,
        x - baseX,
        y - baseY
      );
      return value > 0 ? color : prevColor;
    },
    update() {},
  };
}
