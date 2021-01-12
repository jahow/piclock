import { getSymbolChainValue } from './utils/symbols';
import { textSymbols } from './utils/symbols.definitions';

/**
 * @param {number} baseX
 * @param {number} baseY
 * @param {string} text
 * @param {number} color
 * @param {number} [outlineColor]
 * @return {Widget}
 */
export function textWidget(baseX, baseY, text, color, outlineColor) {
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
      const outlineValue =
        outlineColor !== undefined
          ? getSymbolChainValue(
              textSymbols,
              chars,
              1,
              x - baseX - 1,
              y - baseY
            ) +
            getSymbolChainValue(
              textSymbols,
              chars,
              1,
              x - baseX + 1,
              y - baseY
            ) +
            getSymbolChainValue(
              textSymbols,
              chars,
              1,
              x - baseX,
              y - baseY - 1
            ) +
            getSymbolChainValue(
              textSymbols,
              chars,
              1,
              x - baseX,
              y - baseY + 1
            ) +
            getSymbolChainValue(
              textSymbols,
              chars,
              1,
              x - baseX - 1,
              y - baseY - 1
            ) +
            getSymbolChainValue(
              textSymbols,
              chars,
              1,
              x - baseX + 1,
              y - baseY - 1
            ) +
            getSymbolChainValue(
              textSymbols,
              chars,
              1,
              x - baseX + 1,
              y - baseY + 1
            ) +
            getSymbolChainValue(
              textSymbols,
              chars,
              1,
              x - baseX - 1,
              y - baseY + 1
            )
          : 0;
      return value > 0 ? color : outlineValue > 0 ? outlineColor : prevColor;
    },
    update() {},
  };
}
